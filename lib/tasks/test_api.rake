namespace :test do
  desc "Run API endpoint tests"
  task api: :environment do
    begin
      puts "\nRunning API Tests..."
      puts "----------------------------------------"
      
      # Run specific API controller tests
      controllers = [
        "test/controllers/api/v1/sessions_controller_test.rb",
        "test/controllers/api/v1/registrations_controller_test.rb"
      ]

      controllers.each do |controller|
        puts "\nTesting: #{controller}"
        puts "----------------------------------------"
        system("rails test #{controller}")
        
        unless $?.success?
          puts "\n❌ Tests failed for: #{controller}"
          exit 1
        end
      end

      puts "\n✅ All API tests passed successfully!"
      puts "----------------------------------------"
    rescue => e
      puts "\n❌ Error running tests:"
      puts e.message
      puts e.backtrace
      exit 1
    end
  end
end 