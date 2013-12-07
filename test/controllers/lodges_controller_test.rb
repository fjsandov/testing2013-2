require 'test_helper'
require 'selenium-webdriver'

class LodgesControllerTest < ActionController::TestCase
  test 'new_lodge' do
    begin
      driver = Selenium::WebDriver.for :firefox
      
      name = Lodge.last.nil? ? 'Nuevo lodge' : 'Nuevo ' + Lodge.last.name
      lodge = {
        :name     => name,
        :lat      => -33.571865,
        :long     => -70.813608,
        :category => 'Camping',
        :image    => 'http://images03.olx.cl/ui/16/81/02/1322359039_284327902_2-PARCELA-PARA-PASEOS-EVENTOS-CAMPING-Padre-Hurtado.jpg',
        :address  => 'Av. Siempreviva, Padre Hurtado'
      }

      # Cargo la vista de lodges
      driver.get 'http://0.0.0.0:3000/lodges/'

      # Hago clic sobre el botón nuevo
      new_lodge = driver.find_element :name => 'new_lodge'
      new_lodge.click

      wait = Selenium::WebDriver::Wait.new(:timeout => 10)

      # Espero a que carge la página y obtengo los elementos
      name = wait.until {
        driver.find_element :name => 'lodge[name]'
      }
      lat = driver.find_element :name => 'lodge[lat]'
      long = driver.find_element :name => 'lodge[long]'
      category = driver.find_element :name => 'lodge[category]'
      image = driver.find_element :name => 'lodge[image]'
      address = driver.find_element :name => 'lodge[address]'
      submit_btn = driver.find_element :name => 'commit'
      
      # Ingreso los datos en el formulario
      name.send_keys lodge[:name]
      lat.send_keys lodge[:lat]
      long.send_keys lodge[:long]
      category.send_keys lodge[:category]
      image.send_keys lodge[:image]
      address.send_keys lodge[:address]

      # Envio el formulario
      submit_btn.click
      
      wait = Selenium::WebDriver::Wait.new(:timeout => 10)

      # Espero a que carge la página y obtengo los elementos
      name = wait.until {
        driver.find_element :xpath => '//html/body/div[2]/div/div[2]/dl/dd'
      }
      lat = driver.find_element :xpath => '//html/body/div[2]/div/div[2]/dl/dd[2]'
      long = driver.find_element :xpath => '//html/body/div[2]/div/div[2]/dl/dd[3]'
      category = driver.find_element :xpath => '//html/body/div[2]/div/div[2]/dl/dd[4]'
      image = driver.find_element :xpath => '//html/body/div[2]/div/div[2]/dl/dd[5]'
      address = driver.find_element :xpath => '//html/body/div[2]/div/div[2]/dl/dd[6]'

      # Verificar existencia y el correcto contenido del nuevo lodge
      assert_equal name.text, lodge[:name]
      assert_equal lat.text.to_f, lodge[:lat]
      assert_equal long.text.to_f, lodge[:long]
      assert_equal category.text, lodge[:category]
      assert_equal image.text, lodge[:image]
      assert_equal address.text, lodge[:address]
    ensure
      driver.quit
    end
  end
  
  test 'search_lodge' do
    begin
      search_string = '2'
      driver = Selenium::WebDriver.for :firefox

      # Cargo la vista de lodges
      driver.get 'http://0.0.0.0:3000/lodges/'

      # Obtengo los campos a llenar
      search = driver.find_element :id => 'search-input'

      # Ingreso los datos en el formulario
      search.send_keys search_string

      # Envio el formulario
      search.submit

      wait = Selenium::WebDriver::Wait.new(:timeout => 10)

      # Espero a que carge la página y obtengo los elementos
      result_msg = wait.until {
        driver.find_element :id => 'result-message'
      }
      search = driver.find_element :id => 'search-input'

      # Verificar existencia y el correcto contenido del mensaje de resultados
      assert_not_nil result_msg, 'No se muestra el mensaje de resultados'
      assert_equal result_msg.text, "Results for: #{search_string}"
    ensure
      driver.quit
    end
  end
end
