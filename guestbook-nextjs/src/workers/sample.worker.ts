import { PrismaClient } from "@prisma/client";
import { Worker, Queue } from "bullmq";
import Redis from "ioredis";

const connection = new Redis(process.env.REDIS_URL!, {
  maxRetriesPerRequest: null,
});

export const sampleQueue = new Queue("comment", {
  connection,
  defaultJobOptions: {
    attempts: 2,
    backoff: {
      type: "exponential",
      delay: 5000,
    },
  },
});

const worker = new Worker(
  "comment", // this is the queue name, the first string parameter we provided for Queue()
  async (job) => {
    const data = job?.data;
    console.log(data);
    const prisma = new PrismaClient();
    const comment = await prisma.user.findUnique({
      where: {
        id: data.id,
      },
    });
    console.log(comment);
    const updateUser = await prisma.user.update({
      where: {
        id: data.id,
      },
      data: {
        generatedComment: `GENERATED: ${comment?.comment}`,
      },
    });
    console.log(updateUser);
    console.log("Task executed successfully");
  },
  {
    connection,
    concurrency: 5,
    removeOnComplete: { count: 1000 },
    removeOnFail: { count: 5000 },
  },
);

export default worker;
