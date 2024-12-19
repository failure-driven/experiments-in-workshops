import type { NextApiRequest, NextApiResponse } from "next";
import { PrismaClient } from "@prisma/client";

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
  return res.status(201).json(result);
}
