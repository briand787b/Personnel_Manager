#====================================================================
#                           Classes
class Employee
	@@emp_nums = []
	@@num_emps = 0

	attr_accessor :location
	attr_reader :emp_num, :name

	def initialize name, location
		@location = location
		@name = name
		@@num_emps += 1

		@emp_num = gen_emp_num
		while @@emp_nums.include? @emp_num
			@emp_num = gen_emp_num
		end
		@@emp_nums << self
		puts "Hello #{@name}, your PIN is #{@emp_num}.  Please write it down."
		#puts self
	end

	def self.get_employees
		puts "The following are current employees:"
		@@emp_nums.size.times do |i|
			puts "==================================="
			puts "Employee Number #{i + 1}"
			puts "Name:  #{@@emp_nums[i].name}"
			puts "Location: #{@@emp_nums[i].location}"
			puts "PIN: #{@@emp_nums[i].emp_num}"
		end
	end

	private

	def gen_emp_num
		temp_emp_num = []
		9.times do 
			temp_emp_num << rand(10)
		end
		temp_emp_num.join.to_i
	end

end

#Warning, modifying native classes is dangerous 
class String
	def cap_all_words
		temp = self.split.map(&:capitalize).join(' ')
		temp = temp.split("'").map { |x| x[0].upcase + x[1, x.size] }.join("'")  
	end

	def cap_all_words!
		self.length.times do |a|
			if a == 0 || self[a - 1] == ' ' || self[a - 1] == "'"
				self[a] = self[a].upcase!
			end
		end
		return self
	end
end

#==================================================================
#                           Methods
#Name: init_employees
#Params: array of employee objects from main 
#Returns: An array of all employee objects
#Purpose:  Iterates many times to create all employees
def init_employees emp_arr
	count = 0
	#temp_array = []
	begin
		print "Would you like to enter "
		print (count == 0)? "an" : "another"
		print " employee into the system? (Y/N)\n"
		choice = gets.chomp.upcase
		case choice
			when 'Y'
				puts "What is the new employee's name? (First Last)"
				name = gets.chomp.cap_all_words
				puts "Where does this employee work? (City)"
				location = gets.chomp.cap_all_words
				count += 1
				emp_arr << (Employee.new name, location)
			when 'N'
				return emp_arr
				#return temp_array
			else
				"Sorry that was an invalid response"
			end
	end while choice != 'N' 
end

#Name: transfer
#Params: Array of employee objects from main
#Returns: The new location if successful, nil otherwise
#Purpose: Verifies user's authority and changes curr emp's location
def transfer emp_arr
	count = 0

	begin
		print "Would you like to change the location of "
		print (count == 0)? "an" : "another"
		print " employee? (Y/N)\n"
		choice = gets.chomp.upcase
		case choice
			when 'Y'
				puts "Which employee would you like to transfer?"
				emp_arr.size.times do |i|
					puts "#{i + 1}. #{emp_arr[i].name}"
				end
				puts "Please enter the number next to his/her name:"
				choice2 = gets.chomp.to_i
				if emp_arr[choice2 - 1]
					puts "Please enter this employee's PIN"
					pin = gets.chomp.to_i
					if emp_arr[choice2 - 1].emp_num == pin
						puts "Access Granted"
						puts "Please enter new location:"
						new_loc = gets.chomp.cap_all_words
						return emp_arr[choice2 - 1].location = new_loc
					else
						puts "Access Denied"
					end
				else
					puts "Sorry that was an incorrect index"
				end
			when 'N'
				return nil
			else
				puts "Sorry that was an invalid response"
			end
	end while choice != 'N'
end

#==================================================================
#                            Main

emp_array = []
line_width = 70

begin
	system "cls"
	puts (" = = = = = = = = = = = = = = = = = = = = = = ".center(line_width))
	puts ("|| Welcome to the Personnel Records Keeper ||".center(line_width))
	puts (" = = = = = = = = = = = = = = = = = = = = = = ".center(line_width))
	puts ""
	puts ("Please enter a number from the menu below:".center(line_width))
	puts "1. Add Employees\n2. View Existing Records"
	puts "3. Modify Employee Locations\n4. Quit"
	puts "==========================================================="
	selection = gets.chomp.to_i
	case selection
		when 1
			system "cls"
			init_employees emp_array
			# puts "Press any key to continue"
			# gets
		when 2
			system "cls"
			Employee.get_employees
			puts "\nPress Enter to continue:"
			gets
		when 3
			system "cls"
			transfer emp_array
			puts "\nPress Enter to continue"
			gets
		when 4
			puts "Exiting program..."
		else 
			puts "Sorry that was an invalid response"
		end
end while selection != 4


# emp_array = []
# init_employees (emp_array)

# Employee.get_employees

# transfer emp_array

# puts emp_array[0].location