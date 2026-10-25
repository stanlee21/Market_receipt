#!/bin/bash

#collecting information from customer
read -r -p "Customer name: " customer
read -r -p "Item name: " item
read -r -p "Unit price(FCFA): " price
read -r -p "Quantity: " quantity

if [[ -z "$customer" ]]; then
    customer="Client"
fi 

#calculate subtotal
subtotal=$((price * quantity))

#discount rate
if((subtotal >= 100000)); then
    discount_rate=10
elif((subtotal >= 20000)); then 
    discount_rate=5
else
    discount_rate=0
fi

#calculate discount
discount=$((subtotal * discount_rate / 100))

#calculate amount after discount
taxable_amount=$((subtotal - discount))

#calculating the VAT
vat=$((taxable_amount * 1920 / 10000))

#calculate total
total=$((taxable_amount + vat))

#receipt details
receipt_number=4821
receipt_date=$(date "+%d/%m/%Y %H:%M")

printf "========================================\n"
printf "  MOKOLO WHOLESALE . RECEIPT #%d\n" "$receipt_number"
printf "  %s\n" "$receipt_date"
printf "========================================\n"

printf "Customer: %s\n" "$customer"
printf "Item: %s x %d\n" "$item" "$quantity"
printf "=========================================\n"

printf "%-14s %12s\n" "Subtotal" "$subtotal" . %-14s
printf "Discount %d%%\n" "$discount_rate"
printf "VAT 19.25%% %d\n" "$vat"
printf "===========================================\n"

printf "TOTAL %d\n" "$total"