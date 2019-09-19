# Arquitectura de Software en la Práctica

## Caching en rails

### Objetivos

El objetivo de este práctico es realizar una aplicación de ejemplo con caching que sirva como punto de partida para utilizar a lo largo del curso.

### Procedimiento

Crear el proyecto y los scaffold para *company* y *employee*

````bash
rails new phone-book
rails generate scaffold company name
rails generate scaffold employee company:references last_name first_name phone_number
rails db:migrate
````

Agregar las validaciones a los modelos

````ruby
class Company < ApplicationRecord
  
  validates :name, presence: true, uniqueness: true
  has_many :employees, dependent: :destroy
  
  def to_s
    name
  end
  
end

class Employee < ApplicationRecord
  
  belongs_to :company, touch: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :company, presence: true
  
  def to_s
    “#{first_name} #{last_name}”
  end
  
end
````

Editar ```app/views/companies/index.html.erb``` y agregar información de la cantidad de empleados ejemplo:

```html
<table>
 <thead>
  <tr>
    <th>Name</th>
    <th>Number of employees</th>
    <th colspan=”3"></th>
  </tr>
 </thead>
 <tbody>
  <% @companies.each do |company| %>
    <tr>
      <td><%= company.name %></td>
      <td><%= company.employees.count %></td>
    </tr>
  <% end %>
 </tbody>
</table>
```
luego editar ```app/views/companies/show.html.erb```:

```html
<p id=”notice”><%= notice %></p>
<p>
 <strong>Name:</strong>
 <%= @company.name %>
</p>
<% if @company.employees.any? %>
<h1>Employees</h1>
<table>
 <thead>
  <tr>
    <th>Last name</th>
    <th>First name</th>
    <th>Phone number</th>
  </tr>
 </thead>
 <tbody>
  <% @company.employees.each do |employee| %>
    <tr>
      <td><%= employee.last_name %></td>
      <td><%= employee.first_name %></td>
      <td><%= employee.phone_number %></td>
    </tr>
  <% end %>
 </tbody>
</table>
<% end %>
<%= link_to ‘Edit’, edit_company_path(@company) %> |
<%= link_to ‘Back’, companies_path %>
```
Luego de completar las vistas vamos a proceder a agregar ejemplos, para eso vamos a utilizar la gema *faker*:

```
gem 'faker'
```

en el archivo *seeds.rb* creamos datos de ejemplo:

```ruby
100.times do
 company = Company.new(:name => Faker::Company.name)
 if company.save
  SecureRandom.random_number(500).times do
    company.employees.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      phone_number: Faker::PhoneNumber.phone_number
    )
  end
 end
end
```
luego ejecutamos ```rails db:seed```

### Consigna

En base al comportamiento observado en el ejemplo anterior y los tiempos de respuesta siguiendo la guía de [caching en rails](https://guides.rubyonrails.org/caching_with_rails.html) aplique distintas técnicas incorporadas por rails y compare resultados.
