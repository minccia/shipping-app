<h2> Configurações </h2>

* Versão do Ruby Utilizada: Ruby 3.1.2
* Versão do framework Rails: 7.0.4
* Ferramenta para testes: Rspec
* Test driver: Capybara


Antes de inicializar a aplicação, rode o comando 'rails db:seed' no seu terminal para popular o banco de dados com alguns models pré-cadastrados, sendo essencial para ver e testar as funcionalidades do sistema.
Você terá acesso a dois logins de usuários, um comum e um administrador, na qual o administrador possui alguns acessos a mais do que o usuário comum. Ao clicar no botão 'Fazer Login' localizado na barra de navegação da página inicial, você poderá utilizar as credenciais para se autenticar:

<p>
<h3> Usuário comum </h3>
  * Email: common@sistemadefrete.com.br <br>
  * Senha: 1234567
</p>

<h3> Usuário administrador </h3>
  * Email: admin@sistemadefrete.com.br <br>
  * Senha: 1234567
</p>


<h2> Specs do sistema </h2>
  <h4> Gems utilizadas: </h4>
  
    * FactoryBot: 
       Gem utilizada para automatizar o processo de população do banco de dados, simplificando as etapas de alguns testes e os deixando mais limpos.
  
    * Faker:
       Gem utilizada para criar dados 'falsos', associada com a FactoryBot é utilizada para gerar strings e números aleatórios que servem como valores dos atributos nas instâncias dos models.
  
    * Devise:
       Gem utilizada para gerenciar a autenticação dos usuários comuns e admins.
