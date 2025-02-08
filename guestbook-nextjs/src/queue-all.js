const PrismaClient = require("@prisma/client").PrismaClient;
const Queue = require("bullmq").Queue;

(async () => {
  const queue = new Queue("comment");
  const prisma = new PrismaClient();

  try {
    const comments = await prisma.user.findMany();
    comments.map((record) => {
      queue.add("cars", {
        id: record.id,
        comment: record.comment,
      });
    });
  } catch (error) {
    console.error(error);
  } finally {
    await prisma.$disconnect();
    process.exit(0);
  }
})();
