import type { NextApiRequest, NextApiResponse } from "next";
import { PrismaClient } from "@prisma/client";
import { Queue } from "bullmq";

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse,
) {
  const prisma = new PrismaClient();
  const result = await prisma.user.create({
    data: {
      ...req.body,
    },
  });

  const queue = new Queue("Comment");
  const queueResponse = await queue.add("cars", {
    id: result.id,
    comment: result.comment,
  });
  console.log(queueResponse);
  return res.status(201).json(result);
}
