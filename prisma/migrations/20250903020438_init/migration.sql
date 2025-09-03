-- CreateEnum
CREATE TYPE "public"."Categoria" AS ENUM ('INFRAESTRUTURA', 'ILUMINACAO', 'LIXO', 'SEGURANCA', 'ENCHENTE', 'TRANSPORTE', 'RECICLAGEM', 'EVENTO_COMUNITARIO', 'OUTRO');

-- CreateEnum
CREATE TYPE "public"."Status" AS ENUM ('PENDENTE', 'ABERTO', 'EM_ANDAMENTO', 'RESOLVIDO');

-- CreateEnum
CREATE TYPE "public"."Privacidade" AS ENUM ('PUBLICO', 'ANONIMO');

-- CreateTable
CREATE TABLE "public"."usuarios" (
    "id" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "avatarUrl" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "usuarios_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."localizacoes" (
    "id" TEXT NOT NULL,
    "latitude" DOUBLE PRECISION NOT NULL,
    "longitude" DOUBLE PRECISION NOT NULL,
    "endereco" TEXT,
    "bairro" TEXT,
    "cidade" TEXT,
    "estado" TEXT,
    "cep" TEXT,
    "referencia" TEXT,

    CONSTRAINT "localizacoes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."necessidades" (
    "id" TEXT NOT NULL,
    "titulo" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,
    "categoria" "public"."Categoria" NOT NULL,
    "status" "public"."Status" NOT NULL DEFAULT 'ABERTO',
    "privacidade" "public"."Privacidade" NOT NULL DEFAULT 'PUBLICO',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "autorId" TEXT NOT NULL,
    "localizacaoId" TEXT NOT NULL,

    CONSTRAINT "necessidades_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."fotos" (
    "id" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "necessidadeId" TEXT NOT NULL,

    CONSTRAINT "fotos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."comentarios" (
    "id" TEXT NOT NULL,
    "texto" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "necessidadeId" TEXT NOT NULL,
    "autorId" TEXT NOT NULL,

    CONSTRAINT "comentarios_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."apoios" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "necessidadeId" TEXT NOT NULL,
    "autorId" TEXT NOT NULL,

    CONSTRAINT "apoios_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "usuarios_email_key" ON "public"."usuarios"("email");

-- AddForeignKey
ALTER TABLE "public"."necessidades" ADD CONSTRAINT "necessidades_autorId_fkey" FOREIGN KEY ("autorId") REFERENCES "public"."usuarios"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."necessidades" ADD CONSTRAINT "necessidades_localizacaoId_fkey" FOREIGN KEY ("localizacaoId") REFERENCES "public"."localizacoes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."fotos" ADD CONSTRAINT "fotos_necessidadeId_fkey" FOREIGN KEY ("necessidadeId") REFERENCES "public"."necessidades"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."comentarios" ADD CONSTRAINT "comentarios_necessidadeId_fkey" FOREIGN KEY ("necessidadeId") REFERENCES "public"."necessidades"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."comentarios" ADD CONSTRAINT "comentarios_autorId_fkey" FOREIGN KEY ("autorId") REFERENCES "public"."usuarios"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."apoios" ADD CONSTRAINT "apoios_necessidadeId_fkey" FOREIGN KEY ("necessidadeId") REFERENCES "public"."necessidades"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."apoios" ADD CONSTRAINT "apoios_autorId_fkey" FOREIGN KEY ("autorId") REFERENCES "public"."usuarios"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
