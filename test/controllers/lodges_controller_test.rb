require 'test_helper'
require 'selenium-webdriver'

class LodgesControllerTest < ActionController::TestCase
  test 'search_lodge' do
    begin
      search_string = '1'
      driver = Selenium::WebDriver.for :firefox

      # Cargo la vista de lodges
      driver.get 'http://0.0.0.0:3000/lodges/'

      # Obtengo los campos a llenar
      search = driver.find_element :name => 'search'

      # Ingreso los datos en el formulario
      search.send_keys search_string

      # Envio el formulario
      search.submit

      wait = Selenium::WebDriver::Wait.new(:timeout => 10)

      # Espero a que carge la página y obtengo los elementos
      result_msg = wait.until {
        driver.find_element :id => 'result-message'
      }
      search = driver.find_element :name => 'search'

      # Verificar existencia y el correcto contenido del mensaje de resultados
      assert_not_nil result_msg, 'No se muestra el mensaje de resultados'
      assert_equal result_msg.text, "Results for: #{search_string}"
    ensure
      driver.quit
    end
  end
end
