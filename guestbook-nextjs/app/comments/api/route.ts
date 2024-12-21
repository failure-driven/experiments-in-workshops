import type { NextRequest } from "next/server";
import { PrismaClient } from "@prisma/client";
import { Queue } from "bullmq";

export async function POST(req: NextRequest) {
  const data = await req.json();
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
