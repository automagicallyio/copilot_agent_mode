Feature: Shopping Cart Management
  As a customer of OctoCAT Supply
  I want to manage items in my shopping cart
  So that I can review and purchase products efficiently

  Background:
    Given the user is on the OctoCAT Supply website
    And the Products page is available with items

  # Cart Icon Scenarios
  
  Scenario: Cart icon is visible in the navigation bar
    Given the user is on any page of the website
    Then the cart icon should be visible in the navigation bar
    And the cart icon should display a count of 0 items

  Scenario: Cart icon displays the correct number of items
    Given the user has added 3 items to the cart
    When the user views the navigation bar
    Then the cart icon should display a count of 3 items

  Scenario: Cart icon count updates when items are added
    Given the cart is empty
    When the user adds 2 units of "AI-Powered Cat Feeder" to the cart
    Then the cart icon should display a count of 2 items

  Scenario: Cart icon is clickable and navigates to cart page
    Given the user is on the Products page
    When the user clicks the cart icon
    Then the user should be navigated to the Cart page

  # Cart Page Display Scenarios

  Scenario: Empty cart displays appropriate message
    Given the user has no items in the cart
    When the user navigates to the Cart page
    Then an empty cart message should be displayed
    And a link or button to browse products should be available

  Scenario: Cart page displays all added items
    Given the user has added the following items to the cart:
      | Product Name              | Quantity | Price  |
      | AI-Powered Cat Feeder     | 2        | $149.99|
      | Smart Litter Box Monitor  | 1        | $89.99 |
    When the user navigates to the Cart page
    Then the cart should display 2 different products
    And each product should show its name, quantity, and price

  Scenario: Cart page displays product images
    Given the user has added "AI-Powered Cat Feeder" to the cart
    When the user navigates to the Cart page
    Then the product image should be displayed for "AI-Powered Cat Feeder"

  # Quantity Management Scenarios

  Scenario: User can increase item quantity from cart page
    Given the user has 1 unit of "Smart Litter Box Monitor" in the cart
    When the user clicks the increase quantity button for "Smart Litter Box Monitor"
    Then the quantity should update to 2
    And the item subtotal should be recalculated
    And the cart icon count should update to 2

  Scenario: User can decrease item quantity from cart page
    Given the user has 3 units of "AI-Powered Cat Feeder" in the cart
    When the user clicks the decrease quantity button for "AI-Powered Cat Feeder"
    Then the quantity should update to 2
    And the item subtotal should be recalculated
    And the cart icon count should update to 2

  Scenario: Item is removed when quantity is decreased to zero
    Given the user has 1 unit of "Smart Litter Box Monitor" in the cart
    When the user clicks the decrease quantity button for "Smart Litter Box Monitor"
    Then "Smart Litter Box Monitor" should be removed from the cart
    And the cart should be empty
    And the cart icon count should display 0

  # Remove Item Scenarios

  Scenario: User can remove an item from the cart
    Given the user has the following items in the cart:
      | Product Name              | Quantity |
      | AI-Powered Cat Feeder     | 2        |
      | Smart Litter Box Monitor  | 1        |
    When the user clicks the remove button for "Smart Litter Box Monitor"
    Then "Smart Litter Box Monitor" should be removed from the cart
    And the cart should display only 1 product
    And the cart icon count should display 2 items

  Scenario: Removing all items shows empty cart state
    Given the user has 1 unit of "AI-Powered Cat Feeder" in the cart
    When the user removes "AI-Powered Cat Feeder" from the cart
    Then the empty cart message should be displayed
    And the cart icon count should display 0

  # Price Calculation Scenarios

  Scenario: Cart calculates subtotal correctly
    Given the user has added the following items to the cart:
      | Product Name              | Quantity | Price  |
      | AI-Powered Cat Feeder     | 2        | $149.99|
      | Smart Litter Box Monitor  | 1        | $89.99 |
    When the user views the Cart page
    Then the subtotal should be $389.97

  Scenario: Free shipping applies for orders over $100
    Given the user has items totaling $150.00 in the cart
    When the user views the Cart page
    Then the shipping cost should be $0.00
    And a "Free Shipping" message should be displayed
    And the total should equal the subtotal

  Scenario: Shipping fee applies for orders under $100
    Given the user has items totaling $75.00 in the cart
    When the user views the Cart page
    Then the shipping cost should be $25.00
    And the total should be $100.00

  Scenario: Shipping changes from paid to free when threshold is crossed
    Given the user has items totaling $90.00 in the cart
    And the shipping cost is $25.00
    When the user adds items bringing the subtotal to $110.00
    Then the shipping cost should be $0.00
    And a "Free Shipping" message should be displayed

  Scenario: Total is calculated correctly with shipping
    Given the user has items totaling $50.00 in the cart
    When the user views the Cart page
    Then the subtotal should be $50.00
    And the shipping cost should be $25.00
    And the total should be $75.00

  # Cart Persistence Scenarios

  Scenario: Cart persists after page refresh
    Given the user has added 2 units of "AI-Powered Cat Feeder" to the cart
    When the user refreshes the page
    Then the cart should still contain 2 units of "AI-Powered Cat Feeder"
    And the cart icon should display a count of 2 items

  Scenario: Cart persists across navigation
    Given the user has added items to the cart
    When the user navigates to the About page
    And the user navigates back to the Products page
    Then the cart icon should still display the correct item count
    And the cart contents should remain unchanged

  # Integration with Products Page Scenarios

  Scenario: Adding item from Products page updates cart
    Given the user is on the Products page
    And the cart is empty
    When the user selects a quantity of 3 for "Smart Litter Box Monitor"
    And the user clicks "Add to Cart"
    Then the cart icon should display a count of 3 items
    And no alert message should be displayed

  Scenario: Quantity selector resets after adding to cart
    Given the user is on the Products page
    When the user selects a quantity of 2 for "AI-Powered Cat Feeder"
    And the user clicks "Add to Cart"
    Then the quantity selector for "AI-Powered Cat Feeder" should reset to 0

  # Responsive Design Scenarios

  Scenario: Cart page is responsive on mobile devices
    Given the user is viewing the Cart page on a mobile device
    Then the cart layout should adapt to the smaller screen
    And all cart functionality should remain accessible

  Scenario: Cart icon is visible on mobile navigation
    Given the user is on a mobile device
    Then the cart icon should be visible in the mobile navigation
    And the item count badge should be clearly visible

  # Theme Support Scenarios

  Scenario: Cart page respects dark mode theme
    Given the user has enabled dark mode
    When the user navigates to the Cart page
    Then the cart page should display with dark mode styling
    And all text should be readable against the dark background

  Scenario: Cart page respects light mode theme
    Given the user is using light mode
    When the user navigates to the Cart page
    Then the cart page should display with light mode styling
    And all elements should follow the light theme color scheme

  # Edge Cases and Error Handling

  Scenario: Maximum quantity handling
    Given the user has 99 units of "AI-Powered Cat Feeder" in the cart
    When the user attempts to increase the quantity
    Then the quantity should remain at 99
    Or an appropriate message should inform the user of the maximum

  Scenario: Cart handles products with discounts
    Given the user adds a product with a 20% discount to the cart
    When the user views the Cart page
    Then the discounted price should be displayed
    And the total should reflect the discounted amount

  Scenario: Cart page loads without errors when empty
    Given the cart is empty
    When the user directly navigates to the Cart page URL
    Then the page should load successfully
    And the empty cart message should be displayed

  Scenario: Cart icon works for unauthenticated users
    Given the user is not logged in
    Then the cart icon should still be visible
    And users should be able to add items to the cart
    And the cart functionality should work normally
