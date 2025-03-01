import { PrismaClient } from "@prisma/client";
import { Queue } from "bullmq";
import { NextRequest, NextResponse } from "next/server";

type userData = {
  email: string;
  name: string;
  lastName: string;
  comment: string;
};

export async function POST(req: NextRequest, res: NextResponse) {
  const data = {};
  // NOTE: this is not case insensitive? is there a better way to handle
  if (
    req.method === "POST" &&
    req.headers["content-type"] === "application/json"
  ) {
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
  try {
    const result = await prisma.user.create({
      data: <userData>{
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
  } catch (e) {
    // res.status = 500;
    // return res.json({ error: 'failed to load data' + e })
    // return Response.error(); // { error: `error: ${e.message}` }, { status: 422 });
    return Response.json({ error: `error: ${e.message}` }, { status: 422 });
  }
}
