module Appium::Capybara
  class Appium::Capybara::Node < Capybara::Selenium::Node
    def all_text
      text = native.text

      if text.nil? || text.length <= 0
        text = value
      end

      if text.nil? || text.length <= 0
        text = label
      end

      Capybara::Helpers.normalize_whitespace(text)
    end

    def value
      native.value
    end

    def label
      native.label
    end

    def name
      native.name
    end

    def set(value)
      native.clear
      send_keys(value)
    end

    def send_keys(value)
      native.send_keys(value.to_s)
    end

    def long_press
      action = Appium::TouchAction.new
      action.long_press(element: native, duration: 2000)
      action.perform
    end

    def find_custom(finder, locator)
      native.find_elements(finder, locator).map { |n| self.class.new(driver, n) }
    end

    def inspect
      %(#<#{self.class} name="#{name}">)
    end
  end
end
