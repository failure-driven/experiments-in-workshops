import "../public/styles/main.css";
import { PrismaClient } from '@prisma/client'

export default async function Page() {
  const prisma = new PrismaClient()
  const users = await prisma.user.findMany()

  return (
    <div className="container">
      <h1>guest book</h1>
      <div className="container">
        <ul>
          {users.map(user => (
            <li key={user.id}>{user.email}, {user.name}</li>
          ))}
        </ul>
      </div>
    </div>
  )
}
