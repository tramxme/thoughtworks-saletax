module Tax
  def round_to_nearest_cent(value) #round value to the nearest 0.05 cent
   (value*20).ceil/20.to_f
  end

  def regular_tax(prize) #non-exempt items are subjected to 10% sale tax
    round_to_nearest_cent(prize*0.1)
  end

  def import_tax(prize) #imported items are subjected to an additional 5% import tax
    round_to_nearest_cent(prize*0.05)
  end

end

class Exempt #Include Book, Medical and Food
  include Tax
  def exempt(prize, import = false)
    if import == false
      prize.round(2)
    else
      (prize + import_tax(prize)).round(2)
    end
  end
end

class Nonexempt #Others
  include Tax
  def non_exempt(prize, import = false)
    if import == false
      (prize + regular_tax(prize)).round(2)
    else
      (prize + regular_tax(prize) + import_tax(prize)).round(2)
    end
  end
end


def print_out(text)
  @list_exempt_items = ["book","pills","chocolate","chocolates"]
  tax_sum  = 0
  total = 0 
  input = File.open(text).read #Read the input file
  input.each_line do |line|
    info = line.chomp.split(" ") #Break down the information into an array
    quantity = info[0].to_i #The first index in the array is the quantity
    prize = info[-1].to_f #The last index in the array is the prize
    if @list_exempt_items.any?{|item| info.include?(item)} #Check if the item in the exempt list
      item = Exempt.new
      if info.include?("imported") #Check if the item is imported and apply 5% if it is 
        new_prize = (item.exempt(prize, true))*quantity
        tax_sum += (item.import_tax(prize))*quantity
        total += new_prize
      else #If item is not imported, it is exempted from tax
        new_prize = (item.exempt(prize, false))*quantity
        total += (new_prize)*quantity
      end
    else #If the item is in the non-exempt list
      item = Nonexempt.new
      if info.include?("imported") #Check if the item is imported, if yest, apply 10% sale tax and an additional 5% import tax
        new_prize = (item.non_exempt(prize, true))*quantity
        tax_sum += ((item.regular_tax(prize) + item.import_tax(prize)))*quantity
        total += new_prize
      else #If the item is not imported, apply only 10% sale tax
        new_prize = (item.non_exempt(prize, false))*quantity
        tax_sum += (item.regular_tax(prize))*quantity
        total += new_prize
      end
    end
    output = line.chomp.sub(" at ", " : ").sub(info[-1], new_prize.to_s) #yield output, replace at with ":" and the old value with new
    p output  
  end  
  p "Sale Taxes: " + "%.2f" % tax_sum
  p "Total: #{total.round(2)}"

end

# print_out("input1.txt")
# print_out("input2.txt")
# print_out("input3.txt")




