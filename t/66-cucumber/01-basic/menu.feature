@wip
Feature: correct operation of the menu and immediate linked pages
  As a an end-user, I want to be able to navigate the menu and
  open the screens from the available links. If my authorizations
  don't allow a specific screen, I expect the links not to be in
  the menu.



Background:
  Given a LedgerSMB instance
    And a standard test company


Scenario Outline: Navigate to menu and open screen
  Given a logged in admin
   When I navigate the menu and select the item at "<path>"
   Then I should see the <screen> screen
  Examples:
    | path                                      | screen                   |
#    | Contacts > Add Contact                    | contact creation         |
    | Contacts > Search                         | Contact search           |
    | AR > Search                               | AR search                |
    | AP > Search                               | AP search                |
    | Budgets > Search                          | Budget search            |
    | HR > Employees > Search                   | Employee search          |
    | Order Entry > Reports > Sales Orders      | Sales order search       |
    | Order Entry > Reports > Purchase Orders   | Purchase order search    |
    | Order Entry > Generate > Sales Orders     | generate sales order     |
    | Order Entry > Generate > Purchase Orders  | generate purchase order  |
    | Order Entry > Combine > Sales Orders      | combine sales order      |
    | Order Entry > Combine > Purchase Orders   | combine purchase order   |
    | Quotations > Reports > Quotations         | Quotation search         |
    | Quotations > Reports > RFQs               | RFQ search               |
    | General Journal > Search and GL           | GL search                |