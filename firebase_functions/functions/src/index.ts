import { onRequest } from "firebase-functions/v2/https";
import axios from "axios";
import { defineSecret } from "firebase-functions/params";
import FormData from "form-data";

const PICWISH_KEY = defineSecret("PICWISH_KEY");
const BASE_URL = "https://techhk.aoscdn.com/api/tasks/visual";

export const picwishProxy = onRequest(
  {
    cors: true,
    secrets: [PICWISH_KEY],
  },
  async (req, res) => {
    try {
      const { task, image } = req.body;

      if (!task || !image) {
        res.status(400).json({ error: "Missing task or image" });
        return;
      }

      let endpoint = "";

      switch (task) {
        case "remove-bg":
          endpoint = "/segmentation";
          break;

        case "enhance":
          endpoint = "/scale";
          break;

        case "watermark-remove":
          endpoint = "/external/watermark-remove";
          break;

        case "face-cutout":
          endpoint = "/self-face-cutout";
          break;

        default:
          res.status(400).json({ error: "Invalid task" });
          return;
      }

      const buffer = Buffer.from(image, "base64");

      const form = new FormData();
      form.append("sync", "1");

      form.append(
        task === "watermark-remove" ? "file" : "image_file",
        buffer,
        {
          filename: "file.jpg",
          contentType: "image/jpeg",
        }
      );

      const r = await axios.post(BASE_URL + endpoint, form, {
        headers: {
          "X-API-KEY": PICWISH_KEY.value(),
          ...form.getHeaders(),
        },
      });

      res.json(r.data);
    } catch (e: any) {
      res.status(500).json({ error: e.message });
    }
  }
);
