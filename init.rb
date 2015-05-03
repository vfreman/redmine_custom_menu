Redmine::Plugin.register :redmine_custom_menu do
  name 'Redmine Custom Menu plugin'
  author 'Vincent Fréman'
  description 'Plugin for customize Redmine project menu'
  version '0.0.1'
  url ''
  author_url 'http://www.vfreman.com'
end

Redmine::MenuManager.map :project_menu do |menu|
	
	menu.delete :overview
	menu.delete :activity
	menu.delete :roadmap
	menu.delete :issues
	menu.delete :new_issue
	menu.delete :gantt
	menu.delete :calendar
	menu.delete :news
	menu.delete :documents
	menu.delete :wiki
	menu.delete :boards
	menu.delete :files
	menu.delete :repository
	menu.delete :settings

	# menu.push :overview, { :controller => 'projects', :action => 'show' }
	menu.push :wiki, { :controller => 'wiki', :action => 'show', :id => nil }, :param => :project_id, :caption => :label_project_page,
	          :if => Proc.new { |p| p.wiki && !p.wiki.new_record? }
	menu.push :roadmap, { :controller => 'versions', :action => 'index' }, :param => :project_id,
	          :if => Proc.new { |p| p.shared_versions.any? }
	menu.push :issues, { :controller => 'issues', :action => 'index' }, :param => :project_id, :caption => :label_issue_plural
	menu.push :new_issue, { :controller => 'issues', :action => 'new', :copy_from => nil }, :param => :project_id, :caption => :label_issue_new,
	          :html => { :accesskey => Redmine::AccessKeys.key_for(:new_issue) }
	# menu.push :activity, { :controller => 'activities', :action => 'index' }
	menu.push :gantt, { :controller => 'gantts', :action => 'show' }, :param => :project_id, :caption => :label_gantt
	menu.push :calendar, { :controller => 'calendars', :action => 'show' }, :param => :project_id, :caption => :label_calendar
	menu.push :news, { :controller => 'news', :action => 'index' }, :param => :project_id, :caption => :label_news_plural
	menu.push :documents, { :controller => 'documents', :action => 'index' }, :param => :project_id, :caption => :label_document_plural
	menu.push :boards, { :controller => 'boards', :action => 'index', :id => nil }, :param => :project_id,
	          :if => Proc.new { |p| p.boards.any? }, :caption => :label_board_plural
	menu.push :files, { :controller => 'files', :action => 'index' }, :caption => :label_file_plural, :param => :project_id
	menu.push :repository, { :controller => 'repositories', :action => 'show', :repository_id => nil, :path => nil, :rev => nil },
	          :if => Proc.new { |p| p.repository && !p.repository.new_record? }
	menu.push :settings, { :controller => 'projects', :action => 'settings' }, :last => true
end