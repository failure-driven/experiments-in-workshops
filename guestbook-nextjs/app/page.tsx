import "../public/styles/main.css";
import { PrismaClient } from "@prisma/client";
import Link from "next/link";

export default async function Page() {
  const prisma = new PrismaClient();
  const users = await prisma.user.findMany();

  return (
    <div>
      <Link href="/comments">new comment</Link>
      <div>
        <ul>
          {users.map((user) => (
            <li key={user.id}>
              {user.email}, {user.name}, {user.comment}
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}
