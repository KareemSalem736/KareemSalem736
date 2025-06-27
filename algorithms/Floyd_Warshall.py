import networkx as nx
import matplotlib.pyplot as plt
import time

def main():
    choice = input("1, 2, 3, or 4? ")
    match choice:
        case '1': 
            warshalls()
        case '2':
            floyds()
        case '3':
            graph()
        case '4':
            condensation()
        case _:
            print("Make a choice")
            time.sleep(2)
            main()

def warshalls():
    matrix = [[0, 1, 0, 0, 0],
            [0, 0, 0, 1, 0],
            [0, 0, 1, 1, 0],
            [0, 0, 0, 0, 1],
            [0, 0, 1, 0, 1]]

    print("Original Matrix")
    for i in range(len(matrix)):
        print(matrix[i])

    print("\nreflexive closure")    
    for i in range(len(matrix)):
        matrix[i][i] = 1
        print(matrix[i])

    for k in range(len(matrix)):
        print(f"\nAfter k = {k} (Using node {k} as intermediate):")

        for i in range(len(matrix)):
            for j in range(len(matrix)):
                if matrix[i][j] == 0 and (matrix[i][k] and matrix[k][j]):
                    matrix[i][j] = 1
            print(matrix[i])

def floyds():
    INF = float('inf')
    matrix = [[0,   INF, 4,  -2],
        [INF, 2,   3,   6],
        [-3,  2,   0,   INF],
        [4,   INF, 5,   0]]
    
    print("Original Matrix")
    for i in range(len(matrix)):
        print(matrix[i])

    print("\nreflexive closure")    
    for i in range(len(matrix)):
        matrix[i][i] = 0
        print(matrix[i])

    for k in range(len(matrix)):
        print(f"\nAfter k = {k} (Using node {k} as intermediate):")
        for i in range(len(matrix)):
            for j in range(len(matrix)):
                if matrix[i][k] != INF and matrix[k][j] != INF:
                    matrix[i][j] = min(matrix[i][j], matrix[i][k] + matrix[k][j])
        for row in matrix:
            print(row)
    print("\nFinal Matrix")
    for row in matrix:
        print(row)

def graph():
    labels = ['a', 'b', 'c', 'd', 'e']
    matrix = [[0, 1, 0, 0, 0],
            [0, 0, 0, 1, 0],
            [0, 0, 1, 1, 0],
            [0, 0, 0, 0, 1],
            [0, 0, 1, 0, 1]]
    
    G = nx.DiGraph()

    for i in range(len(matrix)):
        for j in range(len(matrix[i])):
            if matrix[i][j] == 1:
                G.add_edge(labels[i], labels[j])
    
    pos = nx.spring_layout(G)
    nx.draw(G, pos, with_labels=True, node_color='lightblue', edge_color='gray', node_size=2000, font_size=14, arrows=True)
    nx.draw_networkx_edges(G, pos, arrowstyle='-|>', arrowsize=20)
    plt.title("Graph from Adjancency Matrix")
    plt.show()

def condensation():
    labels = ['a', 'b', 'c', 'd', 'e']
    matrix = [[0, 1, 0, 0, 0],
            [0, 0, 0, 1, 0],
            [0, 0, 1, 1, 0],
            [0, 0, 0, 0, 1],
            [0, 0, 1, 0, 1]]
    
    G = nx.DiGraph()

    for i in range(len(matrix)):
        for j in range(len(matrix[i])):
            if matrix[i][j] == 1:
                G.add_edge(labels[i], labels[j])
    
    mapping = {label: i for i, label in enumerate(labels)}
    G_numeric = nx.relabel_nodes(G, mapping)

    sccs = list(nx.strongly_connected_components(G_numeric))
    C = nx.condensation(G_numeric, sccs)

    sccs_labels = {}
    for i, component in enumerate(sccs):
        sccs_labels[i] = "{" + ", ".join(labels[node] for node in component) + "}"

    pos = nx.spring_layout(C)
    nx.draw(C, pos, labels=sccs_labels, with_labels=True, node_color="lightgreen", node_size=2000, font_size=12, arrows=True)
    nx.draw_networkx_edges(C, pos, arrowstyle='-|>', arrowsize=20)
    plt.title("Condensation Graph")
    plt.show()

if __name__ == "__main__":
    main()