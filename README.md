# WeFitDesafioLucasPontes

Este projeto utiliza o padrão de arquitetura **MVVM (Model-View-ViewModel)** combinado com a **Clean Architecture** para promover modularidade, manutenibilidade e escalabilidade. Ele é desenvolvido em Swift, utilizando o framework UIKit e SwiftUI para a interface.

## Estrutura do Projeto

Abaixo está uma visão geral da estrutura de diretórios:


### Módulos

#### 1. **App**
   - **CoordinatorFlow**: Gerencia a navegação do aplicativo utilizando o padrão de Coordenação, facilitando a navegação entre telas sem acoplamento direto entre `ViewControllers`.

#### 2. **Data**
   - Contém a lógica de armazenamento e recuperação de dados, incluindo:
     - **AppStorageOrderManager**: Gerencia o armazenamento de pedidos utilizando `AppStorage` para persistir dados de forma simples.
     - **Order**: Lida com a estrutura de dados relacionada aos pedidos.

#### 3. **Domain**
   - Define a camada de negócio do aplicativo, que inclui:
     - **Entities**: Representa as entidades do domínio, como o `Product`.
     - **Repository**: Interface para os repositórios de dados. Exemplo: `ProductRepository`.
     - **UseCase**: Contém os casos de uso que implementam a lógica de negócio, como `GetProductsUseCase`, que fornece os produtos a serem exibidos.

#### 4. **Presenter**
   - Contém a lógica de apresentação e exibição do aplicativo, utilizando a camada `ViewModel` para conectar `Views` e `UseCases`. Exemplo:
     - **Home**: Inclui `HomeView` e `HomeViewModel`, responsáveis pela interface e pela lógica da tela principal.
     - **Cart**: Contém `CartView` e `CartViewModel` para o gerenciamento do carrinho.
     - **TabBar**: Implementa um `CustomTabBarItemView`, `TabBarAnimator`, e `TabBarController` para a navegação do aplicativo.

#### 5. **Tests**
   - Inclui testes unitários para validar o comportamento das `ViewModels` e `UseCases`.
   - **Mocks**: Contém mocks para testar dependências de forma isolada, como chamadas de API e reposições de dados, assegurando que o comportamento do aplicativo seja testável.

## Principais Tecnologias

- **Swift**: Linguagem principal do projeto.
- **UIKit e SwiftUI**: Utilizados para construir as interfaces do usuário.
- **Combine**: Gerencia a reatividade entre o `ViewModel` e as `Views`.
- **MVVM**: Padrão de projeto que facilita a separação de responsabilidades.
- **Clean Architecture**: Estrutura modular que isola as camadas de domínio, dados e apresentação.

## Como Rodar o Projeto

1. Clone o repositório para a sua máquina:
   ```bash
   git clone https://github.com/usuario/WeFitDesafioLucasPontes.git
