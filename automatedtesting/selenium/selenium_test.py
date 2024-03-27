#!/usr/bin/env python
import datetime
import logging
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options as ChromeOptions
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


def log_timestamp(text):
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    logger.info(f"{timestamp} - {text}")


def login(driver, user, password):
    log_timestamp("Go to login page.")
    driver.get("https://www.saucedemo.com/")
    driver.find_element(By.ID, "user-name").send_keys(user)
    driver.find_element(By.ID, "password").send_keys(password)
    driver.find_element(By.ID, "login-button").click()
    log_timestamp(f"Login with username {user} and password {password} successful")


def add_items_to_cart(driver):
    log_timestamp("Add all items to the cart")
    WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.CLASS_NAME, "inventory_item"))
    )
    items = driver.find_elements(By.CLASS_NAME, "inventory_item")
    for item in items:
        item_name = item.find_element(By.CLASS_NAME, "inventory_item_name").text
        item.find_element(By.CLASS_NAME, "btn_inventory").click()
        log_timestamp(f"Added {item_name}")
    driver.find_element(By.CLASS_NAME, "shopping_cart_link").click()
    log_timestamp("All Items were added to shopping cart.")


def remove_items_to_cart(driver):
    log_timestamp("Remove all items from the cart")
    WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.CLASS_NAME, "cart_item"))
    )
    cart_items = driver.find_elements(By.CLASS_NAME, "cart_item")
    for item in cart_items:
        item_name = item.find_element(By.CLASS_NAME, "inventory_item_name").text
        item.find_element(By.CLASS_NAME, "cart_button").click()
        log_timestamp(f"Removed {item_name}")
    log_timestamp(f"{len(cart_items)} Items are all removed from shopping cart.")


def run_tests():
    """Run the test"""
    log_timestamp("Starting the browser...")
    # Set the path to the Chromium binary
    chrome_binary_path = "/opt/google/chrome"
    chromedriver_path = "/usr/local/bin/chromedriver"

    # Create ChromeOptions object
    options = ChromeOptions()

    # Set the binary location
    options.binary_location = chrome_binary_path
    options.add_argument("--no-sandbox")
    options.add_argument("--headless")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--remote-debugging-port=9222")
    driver = webdriver.Chrome(options=options)
    log_timestamp("Starting the browser...")
    try:
        log_timestamp("Login")
        login(driver, "standard_user", "secret_sauce")
        log_timestamp("Add items")
        add_items_to_cart(driver)
        log_timestamp("Remove items")
        remove_items_to_cart(driver)
    except Exception as e:
        logger.error(f"An error occurred: {str(e)}")
    finally:
        driver.quit()
        log_timestamp("Tests Completed")


if __name__ == "__main__":
    run_tests()
