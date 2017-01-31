include Helpers

desc 'CI scripts'
namespace :ci do
  namespace :carthage do
    carthage_zip_file_name = 'carthage.tar.gz'
    carthage_resolved_file_name = 'Cartfile.resolved'
    carthage_folder_name = 'Carthage'

    task :zip, :src_folder, :output_folder do |_, args|
      output_tar_path = File.join(args[:output_folder], carthage_zip_file_name)

      tar_content = "#{carthage_folder_name} #{carthage_resolved_file_name}"

      sh("pushd #{args[:src_folder]}; tar -zcf #{output_tar_path} #{tar_content}; popd")
    end

    task :unzip, :input_folder, :output_folder  do |_, args|
      input_tar_path = File.join(args[:input_folder], carthage_zip_file_name)
      sh("tar -xzf #{input_tar_path} --directory #{args[:output_folder]}")
    end

    task :use_cached, [:download_folder, :destination_folder] => [:unzip] do |_, args|
      puts '### moving Carthage folder into place from cached download...'
      carthage_folder_path = File.join(args[:download_folder], carthage_folder_name)
      download_cartfile_resolved = File.join(args[:download_folder], carthage_resolved_file_name)
      sh("mv #{carthage_folder_path} #{download_cartfile_resolved} #{args[:destination_folder]}")
    end

    task :smart_fetch, :src_folder, :download_folder, :output_folder do |_, args|
      puts '### getting Carthage from cache or recreating...'
      source_cartfile_resolved = File.join(args[:src_folder], carthage_resolved_file_name)
      download_cartfile_resolved = File.join(args[:download_folder], carthage_resolved_file_name)

      Rake::Task['ci:carthage:unzip'].invoke(args[:download_folder], args[:download_folder])

      sh("diff #{source_cartfile_resolved} #{download_cartfile_resolved}") do |contents_equal, _|
        if contents_equal
          Rake::Task['ci:carthage:use_cached'].invoke(args[:download_folder], args[:output_folder])
          Rake::Task['ci:carthage:zip'].invoke(args[:output_folder], args[:output_folder])
        else
          Rake::Task['dependencies:fetch'].invoke()
          Rake::Task['ci:carthage:zip'].invoke(args[:src_folder], args[:output_folder])
        end
      end
    end
  end
end
