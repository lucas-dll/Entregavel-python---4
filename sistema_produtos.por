programa
{
    inclua biblioteca Tipos --> tipos
    inclua biblioteca Texto --> texto
    inclua biblioteca Matematica --> matematica

    // Vetores paralelos: o mesmo índice identifica um produto completo.
    cadeia nomes[100], categorias[100]
    real precos[100]

    funcao inteiro ler_inteiro(cadeia mensagem, inteiro minimo, inteiro maximo)
    {
        cadeia entrada
        enquanto (verdadeiro)
        {
            escreva(mensagem)
            leia(entrada)
            se (tipos.cadeia_e_inteiro(entrada, 10))
            {
                inteiro valor = tipos.cadeia_para_inteiro(entrada, 10)
                se (valor >= minimo e valor <= maximo)
                {
                    retorne valor
                }
            }
            escreva("Informe um número inteiro entre ", minimo, " e ", maximo, ".\n")
        }
    }

    funcao real ler_preco(cadeia mensagem)
    {
        cadeia entrada
        enquanto (verdadeiro)
        {
            escreva(mensagem)
            leia(entrada)
            entrada = texto.substituir(entrada, ",", ".")
            // Também aceita preços digitados sem casas decimais.
            se (tipos.cadeia_e_inteiro(entrada, 10))
            {
                entrada = entrada + ".0"
            }
            se (tipos.cadeia_e_real(entrada))
            {
                real valor = tipos.cadeia_para_real(entrada)
                se (valor >= 0.0)
                {
                    retorne valor
                }
            }
            escreva("Informe um preço válido, maior ou igual a zero.\n")
        }
    }

    funcao cadeia ler_texto(cadeia mensagem)
    {
        cadeia entrada
        enquanto (verdadeiro)
        {
            escreva(mensagem)
            leia(entrada)
            se (texto.substituir(entrada, " ", "") != "")
            {
                retorne entrada
            }
            escreva("Este campo não pode ficar vazio.\n")
        }
    }

    funcao exibir_produto(inteiro indice)
    {
        escreva(nomes[indice], " | R$ ",
                matematica.arredondar(precos[indice], 2),
                " | ", categorias[indice], "\n")
    }

    funcao inicio()
    {
        escreva("SISTEMA DE PRODUTOS — SEMANA 04\n")
        inteiro quantidade = ler_inteiro("Quantidade de produtos (0 a 100): ", 0, 100)

        se (quantidade == 0)
        {
            escreva("Nenhum produto cadastrado.\n")
            retorne
        }

        // Cadastro: o índice e a quantidade substituem o append() da lista.
        para (inteiro indice = 0; indice < quantidade; indice++)
        {
            escreva("\nProduto ", indice + 1, "\n")
            nomes[indice] = ler_texto("Nome: ")
            precos[indice] = ler_preco("Preço: R$ ")
            categorias[indice] = ler_texto("Categoria: ")
        }

        real valor_limite = ler_preco("\nValor para filtrar: R$ ")
        inteiro opcao = ler_inteiro("Filtrar 1 - acima ou 2 - abaixo: ", 1, 2)

        escreva("\n=============================================\n")
        escreva("RELATÓRIO FINAL\n=============================================\n")
        escreva("Total de produtos: ", quantidade, "\n\nPRODUTOS CADASTRADOS\n")
        para (inteiro indice = 0; indice < quantidade; indice++)
        {
            exibir_produto(indice)
        }

        // Filtragem estrita: preços iguais ao limite não são incluídos.
        se (opcao == 1)
        {
            escreva("\nPRODUTOS ACIMA DE R$ ", valor_limite, "\n")
        }
        senao
        {
            escreva("\nPRODUTOS ABAIXO DE R$ ", valor_limite, "\n")
        }
        logico encontrou_produto = falso
        para (inteiro indice = 0; indice < quantidade; indice++)
        {
            se ((opcao == 1 e precos[indice] > valor_limite) ou
                (opcao == 2 e precos[indice] < valor_limite))
            {
                exibir_produto(indice)
                encontrou_produto = verdadeiro
            }
        }
        se (nao encontrou_produto)
        {
            escreva("Nenhum produto encontrado.\n")
        }

        // Bubble sort crescente: troca os três campos para manter os vínculos.
        para (inteiro passagem = 0; passagem < quantidade - 1; passagem++)
        {
            para (inteiro indice = 0; indice < quantidade - 1 - passagem; indice++)
            {
                se (precos[indice] > precos[indice + 1])
                {
                    real preco_auxiliar = precos[indice]
                    precos[indice] = precos[indice + 1]
                    precos[indice + 1] = preco_auxiliar

                    cadeia nome_auxiliar = nomes[indice]
                    nomes[indice] = nomes[indice + 1]
                    nomes[indice + 1] = nome_auxiliar

                    cadeia categoria_auxiliar = categorias[indice]
                    categorias[indice] = categorias[indice + 1]
                    categorias[indice + 1] = categoria_auxiliar
                }
            }
        }
        escreva("\nPREÇOS CRESCENTES\n")
        para (inteiro indice = 0; indice < quantidade; indice++)
        {
            exibir_produto(indice)
        }

        // Um novo vetor de índices equivale à nova lista criada por sorted().
        // O bubble sort decrescente preserva os vetores já ordenados acima.
        inteiro ordem_decrescente[100]
        para (inteiro indice = 0; indice < quantidade; indice++)
        {
            ordem_decrescente[indice] = indice
        }
        para (inteiro passagem = 0; passagem < quantidade - 1; passagem++)
        {
            para (inteiro indice = 0; indice < quantidade - 1 - passagem; indice++)
            {
                se (precos[ordem_decrescente[indice]] <
                    precos[ordem_decrescente[indice + 1]])
                {
                    inteiro indice_auxiliar = ordem_decrescente[indice]
                    ordem_decrescente[indice] = ordem_decrescente[indice + 1]
                    ordem_decrescente[indice + 1] = indice_auxiliar
                }
            }
        }
        escreva("\nPREÇOS DECRESCENTES\n")
        para (inteiro indice = 0; indice < quantidade; indice++)
        {
            exibir_produto(ordem_decrescente[indice])
        }

        // Simulação de set(): só guarda a categoria se ainda não existir.
        cadeia categorias_unicas[100]
        inteiro quantidade_categorias = 0
        para (inteiro indice = 0; indice < quantidade; indice++)
        {
            logico categoria_repetida = falso
            para (inteiro outra = 0; outra < quantidade_categorias; outra++)
            {
                se (categorias[indice] == categorias_unicas[outra])
                {
                    categoria_repetida = verdadeiro
                }
            }
            se (nao categoria_repetida)
            {
                categorias_unicas[quantidade_categorias] = categorias[indice]
                quantidade_categorias++
            }
        }
        escreva("\nCATEGORIAS ÚNICAS\n")
        para (inteiro indice = 0; indice < quantidade_categorias; indice++)
        {
            escreva("- ", categorias_unicas[indice], "\n")
        }

        // Laço equivalente a min(), max() e sum().
        real menor_preco = precos[0], maior_preco = precos[0], soma_precos = 0.0
        para (inteiro indice = 0; indice < quantidade; indice++)
        {
            se (precos[indice] < menor_preco)
            {
                menor_preco = precos[indice]
            }
            se (precos[indice] > maior_preco)
            {
                maior_preco = precos[indice]
            }
            soma_precos = soma_precos + precos[indice]
        }

        // Portugol não tem tuplas. O vetor representa (menor, maior, média).
        real estatisticas[3]
        estatisticas[0] = menor_preco
        estatisticas[1] = maior_preco
        estatisticas[2] = soma_precos / quantidade

        escreva("\nESTATÍSTICAS\n")
        escreva("Menor preço: R$ ", matematica.arredondar(estatisticas[0], 2), "\n")
        escreva("Maior preço: R$ ", matematica.arredondar(estatisticas[1], 2), "\n")
        escreva("Média dos preços: R$ ", matematica.arredondar(estatisticas[2], 2), "\n")
    }
}
