require 'test_helper'
require 'selenium-webdriver'

class CommentsControllerTest < ActionController::TestCase
  test 'make_comment' do
    begin
      # Creo un lodge
      lodge = lodges(:one)
      driver = Selenium::WebDriver.for :firefox

      comment = {
          :email => 'ing.cmolina@gmail.com',
          :message => 'Un buen lugar para pasar la noche',
          :quality => 4,
          :price => 5
      }

      # Cargo la vista del lodge
      driver.get 'http://0.0.0.0:3000/lodges/' + lodge.id.to_s

      # Obtengo los campos a llenar
      email = driver.find_element :id => 'comment_email'
      message = driver.find_element :id => 'comment_message'
      quality = driver.find_element :id => 'comment_quality'
      price = driver.find_element :id => 'comment_price'

      # Ingreso los datos en el formulario
      email.send_keys comment[:email]
      message.send_keys comment[:message]
      quality.send_keys comment[:quality]
      price.send_keys comment[:price]

      # Envio el commentario
      email.submit

      wait = Selenium::WebDriver::Wait.new(:timeout => 10)
      # Espero a que carge la página y obtengo los elementos
      # del comentario recién enviado. Debe ser el primero a mostrar
      email = wait.until {
        driver.find_element :class => 'media-heading'
      }
      message = driver.find_element :class => 'message'
      quality = driver.find_element :class => 'quality'
      price = driver.find_element :class => 'price'

      # Verifico se ingresó correctamente
      str = ' ingresad@ no corresponde'
      assert_equal email.text, comment[:email],
                   'El email ' + str
      assert_equal message.text, comment[:message],
                   'El mensaje ' + str
      assert_equal quality.text.to_i, comment[:quality],
                   'La calidad ' + str
      assert_equal price.text.to_i, comment[:price],
                   'El precio ' + str
    ensure
      driver.quit
    end
  end
end
