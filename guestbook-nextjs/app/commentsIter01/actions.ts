"use server";

import { PrismaClient } from "@prisma/client";
import { revalidatePath } from "next/cache";

export type UserData = {
  email: string;
  name: string;
  lastName: string;
  comment: string;
};

const prisma = new PrismaClient();

export default async function createComment(
  prevState: {
    message: string;
    fields: UserData;
  },
  formData: FormData
): Promise<{ message: string; fields: UserData }> {
  await new Promise((res) => setTimeout(res, 1000));
  console.log(prevState);
  const rawFormData = Object.fromEntries(formData);
  try {
    console.log(rawFormData);
    const result = await prisma.user.create({
      data: <UserData>{
        email: formData.get("email"),
        name: formData.get("name"),
        lastName: formData.get("lastName"),
        comment: formData.get("comment"),
      },
    });
    // NextResponse.json({ id: result.id });
    revalidatePath("/");
    return { message: `Added comment ${result.id}`, fields: rawFormData as UserData };
  } catch (e) {
    // console.error("error occurred");
    // console.error(JSON.stringify(e));
    // NextResponse.json(
    //   { error: `error occurred: ${e.name}` },
    //   { status: 422 }
    // );
    return { message: `error occurred: ${e.name}`, fields: rawFormData as UserData };
  }
  // res.status(405).json({ error: 'Method not allowed' });
}
