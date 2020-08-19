*** Settings ***
Library     String


*** Test Cases ***
Test Robot Framework Logging
  Log  Test Logging
  Log Many  First Entry   Second Entry
  Log To Console  Display to console while Robot is running