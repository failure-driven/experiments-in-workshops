import { PrismaClient } from "@prisma/client";

const users = [
  {
    email: "darlene@example.com",
    name: "Darlene",
    lastName: "Alderson",
    comment:
      "Cool place, I guess. Might hack it later. Just kidding. Or am " +
      "I? ;) Thanks for having me.",
  },
  {
    email: "tyrell@example.com",
    name: "Tyrell",
    lastName: "Wellick",
    comment:
      "This is perfection. A place worthy of my presence. Thank you " +
      "for hosting me in such an impeccable manner.",
  },
  {
    email: "elliot@example.com",
    name: "Elliot",
    lastName: "Alderson",
    comment:
      "Nice... I guess. But let’s be real, this world is a glitch. " +
      "Nothing is as it seems. Thanks.",
  },
];

async function seedUsers() {
  // NOTE: assuming db is up and migrated
  const prisma = new PrismaClient();
  // more on CRUD queries
  // https://www.prisma.io/docs/orm/prisma-client/queries/crud
  // but maybe moving to something more SQL would be better
  prisma.user.deleteMany({});
  const deletedUsers = await prisma.user.deleteMany({});

  const insertedUsers = await Promise.all(
    users.map(async (user) => {
      await prisma.user.create({
        data: {
          ...user,
        },
      });
    }),
  );

  return [deletedUsers, insertedUsers];
}

export async function GET() {
  try {
    // DOES prisma have somthing around transactions?
    // the below BEGIN, COMMIT, ROLLBACK is from NextJS tutorial
    // https://nextjs.org/learn/dashboard-app/setting-up-your-database#seed-your-database
    //   await client.sql`BEGIN`;
    await seedUsers();
    //   await client.sql`COMMIT`;

    return Response.json({ message: "Database seeded successfully" });
  } catch (error) {
    //   await client.sql`ROLLBACK`;
    return Response.json({ error }, { status: 500 });
  }
}
