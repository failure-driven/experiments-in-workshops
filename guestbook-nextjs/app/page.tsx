import "../public/styles/main.css";
import { PrismaClient } from "@prisma/client";
import Link from "next/link";

export default async function Page() {
  const prisma = new PrismaClient();
  const users = await prisma.user.findMany();

  return (
    <div>
      <ul>
        <li>
          <Link href="/comments" data-testid="new-comment">new comment API</Link>
        </li>
        <li>
          <Link href="/comments/new">new comment FORM data</Link>
        </li>
        <li>
          <Link href="/commentsIter01">new comments iter 01</Link>
        </li>
      </ul>
      <div>
        <ul data-testid="comment-list">
          {users.map((user) => (
            <li key={user.id}>
              <ul>
                <li data-testid="comment-email">{user.email}</li>
                <li>{user.name}</li>
                <li>{user.comment}</li>
                <li>{user.generatedComment}</li>
                <li>{user.useGeneratedComment ? "TRUE" : "FALSE"}</li>
              </ul>
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}
