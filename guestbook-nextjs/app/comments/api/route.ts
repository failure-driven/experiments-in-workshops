import type { NextRequest } from "next/server";
import { PrismaClient } from "@prisma/client";
import { Queue } from "bullmq";

export async function POST(req: NextRequest) {
  const data = {};
  // NOTE: this is not case insensitive? is there a better way to handle
  if (req.headers.get("content-type") === "application/json") {
    Object.assign(data, await req.json());
  } else {
    // 'content-type': 'multipart/form-data;
    //                  boundary=----WebKitFormBoundaryXXXXXXXXXXXXXXXX',
    const formData = await req.formData();
    data["email"] = formData.get("email");
    data["name"] = formData.get("name");
    data["lastName"] = formData.get("lastName");
    data["comment"] = formData.get("comment");
  }
  const prisma = new PrismaClient();
  console.log(data);
  const result = await prisma.user.create({
    data: {
      ...data,
    },
  });

  const queue = new Queue("comment");
  const queueResponse = await queue.add("cars", {
    id: result.id,
    comment: result.comment,
  });
  console.log(queueResponse);
  return Response.json({ result });
}
