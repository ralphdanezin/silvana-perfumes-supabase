-- Script para criar a tabela de perfumes no Supabase
-- Execute este script no Editor SQL do Supabase

-- Criar tabela de perfumes
CREATE TABLE public.perfumes (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nome TEXT NOT NULL,
  marca TEXT,
  descricao TEXT,
  preco DECIMAL(10,2),
  estoque INTEGER DEFAULT 0,
  imagem_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Adicionar políticas de segurança para permitir acesso anônimo para leitura
ALTER TABLE public.perfumes ENABLE ROW LEVEL SECURITY;

-- Política para permitir leitura anônima
CREATE POLICY "Permitir leitura anônima" 
  ON public.perfumes 
  FOR SELECT 
  USING (true);

-- Política para permitir inserção por usuários autenticados
CREATE POLICY "Permitir inserção por usuários autenticados" 
  ON public.perfumes 
  FOR INSERT 
  TO authenticated 
  WITH CHECK (true);

-- Política para permitir atualização por usuários autenticados
CREATE POLICY "Permitir atualização por usuários autenticados" 
  ON public.perfumes 
  FOR UPDATE 
  TO authenticated 
  USING (true);

-- Política para permitir exclusão por usuários autenticados
CREATE POLICY "Permitir exclusão por usuários autenticados" 
  ON public.perfumes 
  FOR DELETE 
  TO authenticated 
  USING (true);

-- Inserir alguns dados de exemplo
INSERT INTO public.perfumes (nome, marca, descricao, preco, estoque, imagem_url)
VALUES 
  ('Perfume A', 'Marca X', 'Uma fragrância floral com notas de jasmim', 129.90, 10, 'https://exemplo.com/imagem1.jpg'),
  ('Perfume B', 'Marca Y', 'Fragrância cítrica refrescante', 89.90, 15, 'https://exemplo.com/imagem2.jpg'),
  ('Perfume C', 'Marca Z', 'Notas amadeiradas com toque de baunilha', 199.90, 5, 'https://exemplo.com/imagem3.jpg');
