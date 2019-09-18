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
