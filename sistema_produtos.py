"""Sistema de produtos — Entregável de Python, Semana 04."""

from math import isfinite


def ler_inteiro(mensagem, minimo, maximo):
    while True:
        try:
            valor = int(input(mensagem))
            if minimo <= valor <= maximo:
                return valor
        except ValueError:
            pass
        print(f"Informe um número inteiro entre {minimo} e {maximo}.")


def ler_preco(mensagem):
    while True:
        try:
            valor = float(input(mensagem).strip().replace(",", "."))
            if isfinite(valor) and valor >= 0:
                return valor
        except ValueError:
            pass
        print(f"Informe um preço válido, maior ou igual a zero.")


def ler_texto(mensagem):
    while True:
        texto = input(mensagem).strip()
        if texto:
            return texto
        print(f"Este campo não pode ficar vazio.")


def cadastrar_produtos():
    produtos = []
    # O mesmo limite é usado nos vetores da versão em Portugol.
    quantidade = ler_inteiro("Quantidade de produtos (0 a 100): ", 0, 100)
    for indice in range(quantidade):
        print(f"\nProduto {indice + 1}")
        nome = ler_texto("Nome: ")
        preco = ler_preco("Preço: R$ ")
        categoria = ler_texto("Categoria: ")
        produtos.append([nome, preco, categoria])
    return produtos


def filtrar_produtos(produtos, valor_limite, opcao):
    filtrados = []
    for produto in produtos:
        preco = produto[1]
        if (opcao == 1 and preco > valor_limite) or (
            opcao == 2 and preco < valor_limite
        ):
            filtrados.append(produto)
    return filtrados


def exibir_produtos(titulo, produtos):
    print(f"\n{titulo}")
    if not produtos:
        print(f"Nenhum produto encontrado.")
    for nome, preco, categoria in produtos:
        print(f"{nome} | R$ {preco:.2f} | {categoria}")


def main():
    print(f"SISTEMA DE PRODUTOS — SEMANA 04")
    produtos = cadastrar_produtos()
    if not produtos:
        print(f"Nenhum produto cadastrado.")
        return

    valor_limite = ler_preco("\nValor para filtrar: R$ ")
    opcao = ler_inteiro("Filtrar 1 - acima ou 2 - abaixo: ", 1, 2)
    filtrados = filtrar_produtos(produtos, valor_limite, opcao)
    criterio = "ACIMA" if opcao == 1 else "ABAIXO"

    categorias_unicas = set(produto[2] for produto in produtos)
    precos = [produto[1] for produto in produtos]
    estatisticas = (min(precos), max(precos), sum(precos) / len(precos))
    menor_preco, maior_preco, media_precos = estatisticas

    print(f"\n{'=' * 45}\nRELATÓRIO FINAL\n{'=' * 45}")
    print(f"Total de produtos: {len(produtos)}")
    exibir_produtos("PRODUTOS CADASTRADOS", produtos)
    exibir_produtos(
        f"PRODUTOS {criterio} DE R$ {valor_limite:.2f}", filtrados
    )

    # sort() modifica a lista original; sorted() cria outra lista.
    produtos.sort(key=lambda produto: produto[1])
    exibir_produtos("PREÇOS CRESCENTES", produtos)
    produtos_decrescentes = sorted(
        produtos, key=lambda produto: produto[1], reverse=True
    )
    exibir_produtos("PREÇOS DECRESCENTES", produtos_decrescentes)

    print(f"\nCATEGORIAS ÚNICAS")
    # O conjunto não tem ordem; sorted() organiza somente sua exibição.
    for categoria in sorted(categorias_unicas):
        print(f"- {categoria}")

    print(f"\nESTATÍSTICAS")
    print(f"Menor preço: R$ {menor_preco:.2f}")
    print(f"Maior preço: R$ {maior_preco:.2f}")
    print(f"Média dos preços: R$ {media_precos:.2f}")


if __name__ == "__main__":
    main()
