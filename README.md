# Classificador de Phishing com Programação Genética

Este repositório contém um projeto de pesquisa que utiliza **Programação Genética (GP)** através do framework **PonyGE2** para desenvolver classificadores de phishing que superam algoritmos de Machine Learning tradicionais.

## 🎯 Objetivo

Desenvolver um classificador de phishing utilizando Programação Genética que supere os algoritmos de Machine Learning tradicionais em pelo menos uma métrica de avaliação, preferencialmente o **F1-Score**.

## 📊 Resultados Alcançados

- **Melhor Fitness de Treino**: 0.9216 (92.16%)
- **Melhor Fitness de Teste**: 0.9187 (91.87%)
- **Métrica de Avaliação**: F1-Score
- **Gerações**: 200

## 📁 Estrutura do Projeto

```
├── data/
│   ├── phishing_sbseg2020_fixed.csv    # Dataset original (5.454 amostras)
│   └── df_70.30/
│       ├── treino.csv                  # Dataset de treino (3.817 amostras - 70%)
│       └── teste.csv                   # Dataset de teste (1.637 amostras - 30%)
├── grammars/
│   └── Classification_phishing.bnf     # Gramática BNF para geração dos classificadores
├── parameters/
│   └── classificationPhishing.txt      # Parâmetros de configuração do PonyGE2
├── PonyGE2/                            # Framework de Programação Genética
│   ├── src/
│   │   └── ponyge.py                   # Script principal
│   ├── results/                        # Resultados dos experimentos
│   └── requirements.txt                # Dependências do PonyGE2
├── doc/
│   └── Grammar_based_AutoML_Approach_to_Learn_Classifiers_for_Phishing_Detection.pdf
└── notebooks/                          # Jupyter notebooks (se houver)
```

## 📋 Pré-requisitos

### Dependências Python

```bash
pip install -r PonyGE2/requirements.txt
```

**Principais dependências:**
- numpy
- scipy
- matplotlib
- pandas
- scikit-learn>=0.23.2

### Ambiente Recomendado

- Python 3.5 ou superior
- Anaconda (recomendado para gerenciamento de dependências)

## 🚀 Como Executar

### Execução Principal

```bash
cd PonyGE2/src
python ponyge.py --parameters ../../parameters/classificationPhising.txt
```

### Execução com Saída Verbosa

```bash
cd PonyGE2/src
python ponyge.py --parameters ../../parameters/classificationPhising.txt --verbose
```

### Verificar Ajuda

```bash
cd PonyGE2/src
python ponyge.py --help
```

## ⚙️ Configuração do Experimento

### Dataset

- **Fonte**: `phishing_sbseg2020_fixed.csv`
- **Features**: 18 características de websites
  - `has_long_URL`, `has_long_domain`, `has_long_subdomain`
  - `suspect_subdomain_quantity`, `suspect_path_quantity`
  - `appears_to_redirect`, `prefix_suffix`, `having_at_symbol`
  - `has_URL_encoded`, `suspect_separators_quantity`
  - `has_form_reference`, `explored_tld`, `has_homographic_word`
  - `subdomain_forging_tld`, `host_on_greylist`, `has_valid_SSL`
  - `recent_validated_SSL`, `recent_registered_domain`
- **Target**: `Result` (0 = legítimo, 1 = phishing)
- **Divisão**: 70% treino (3.817 amostras) / 30% teste (1.637 amostras)

### Parâmetros do PonyGE2

| Parâmetro | Valor |
|-----------|-------|
| **População** | 500 |
| **Gerações** | 200 |
| **Crossover** | Subtree (0.75) |
| **Mutação** | int_flip_per_codon |
| **Seleção** | Tournament (tamanho 2) |
| **Métrica de Erro** | F1-Score |
| **Profundidade Máxima** | 17 |
| **Função Fitness** | supervised_learning.classification |

### Gramática BNF

A gramática define as operações matemáticas disponíveis para construção dos classificadores:

- **Operações Aritméticas**: `+`, `-`, `*`, `pdiv` (divisão protegida)
- **Funções Matemáticas**: `psqrt`, `abs`, `sin`, `tanh`, `exp`, `plog`
- **Variáveis**: x[:, 0] até x[:, 17] (18 features do dataset)

## 📈 Melhor Classificador Encontrado

### Expressão Fenótipo
```python
pdiv(plog(x[:, 5]), x[:, 8] + x[:, 14]) - plog(plog(x[:, 15]) * pdiv(np.exp(x[:, 9]), np.exp(x[:, 15])) - np.exp(psqrt(np.tanh(np.tanh(psqrt(np.sin(x[:, 0]))))))) * pdiv(x[:, 17], pdiv(np.tanh(x[:, 17]), plog(x[:, 0]))) - np.abs(np.abs(x[:, 2]) * np.abs(np.abs(np.sin(plog(np.sin(pdiv(x[:, 17], x[:, 15]))))) * psqrt(x[:, 9])) - np.tanh(np.tanh(np.abs(np.exp(np.abs(np.sin(x[:, 13])))))) + np.exp(np.tanh(x[:, 2]))) - np.tanh(plog(psqrt(psqrt(np.exp(pdiv(np.tanh(x[:, 6]), x[:, 12]))))))
```

### Performance
- **Fitness de Treino**: 0.9216
- **Fitness de Teste**: 0.9187
- **Geração**: 200

## 📖 Referências

### Artigo Relacionado
O projeto está baseado no artigo científico:
`Grammar_based_AutoML_Approach_to_Learn_Classifiers_for_Phishing_Detection.pdf`

### Framework PonyGE2
- **Citação**: Fenton, M., McDermott, J., Fagan, D., Forstenlechner, S., Hemberg, E., and O'Neill, M. PonyGE2: Grammatical Evolution in Python. arXiv preprint, arXiv:1703.08535, 2017.
- **Repositório Original**: https://github.com/PonyGE/PonyGE2
- **Documentação**: https://github.com/PonyGE/PonyGE2/wiki

## 🔬 Metodologia

1. **Preparação dos Dados**: Dataset dividido em treino/teste (70/30)
2. **Configuração da Gramática**: Definição das operações matemáticas permitidas
3. **Evolução**: Execução do algoritmo genético por 200 gerações
4. **Avaliação**: Uso do F1-Score como métrica de fitness
5. **Seleção**: Melhor indivíduo baseado na performance de teste

## 📊 Estrutura dos Resultados

Os experimentos geram automaticamente:
- `best.txt`: Melhor indivíduo encontrado
- `stats.tsv`: Estatísticas de todas as gerações
- `best_fitness.pdf`: Gráfico da evolução do fitness
- `parameters.txt`: Parâmetros utilizados no experimento

## 🤝 Contribuição

Este é um projeto de pesquisa acadêmica. Para contribuições ou questões, consulte a documentação do PonyGE2 e os parâmetros de configuração específicos do projeto.

## 📄 Licença

Este projeto utiliza o PonyGE2, que está licenciado sob GNU General Public License v3.0. 