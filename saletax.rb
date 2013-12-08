module Tax
  def round_to_nearest_cent(value)
   (value*20).ceil/20.to_f
  end

  def exempt(prize)
    prize
  end

  def regular_tax(prize)
    round_to_nearest_cent(prize*0.1)
  end

  def import_tax(prize)
    round_to_nearest_cent(prize*0.05)
  end

end

class Exempt
  include Tax
end

class Nonexempt
  include Tax
  def non_exempt(prize, import = false)
    if import == false
      (prize + regular_tax(prize)).round(2)
    else
      (prize + regular_tax(prize) + import_tax(prize)).round(2)
    end
  end

end

@list_exempt_items = ["book","pills","chocolate","chocolates"]

def print_out(text)
  tax_sum  = 0
  total = 0 
  input = File.open(text).read
  p "Output"
  input.each_line do |line|
    info = line.chomp.split(" ")
    quantity = info[0].to_i
    prize = info[-1].to_f
    if @list_exempt_items.any?{|item| info.include?(item)}
      item = Exempt.new
      if info.include?("imported")
        new_prize = (item.exempt(prize) + item.import_tax(prize))*quantity
        tax_sum += (item.import_tax(prize))*quantity
        total += new_prize
      else
        new_prize = (item.exempt(prize))*quantity
        total += (new_prize)*quantity
      end
    else
      item = Nonexempt.new
      if info.include?("imported")
        new_prize = (item.non_exempt(prize, true))*quantity
        tax_sum += ((item.regular_tax(prize) + item.import_tax(prize)))*quantity
        total += new_prize
      else
        new_prize = (item.non_exempt(prize, false))*quantity
        tax_sum += (item.regular_tax(prize))*quantity
        total += new_prize
      end
    end
    output = line.chomp.sub(" at ", " : ").sub(info[-1], new_prize.to_s)
    p output  
  end  
  p "Sale Taxes: #{tax_sum.round(2)}"
  p "Total: #{total.round(2)}"
  p "==============="
  
end

print_out("input1.txt")
print_out("input2.txt")
print_out("input3.txt")