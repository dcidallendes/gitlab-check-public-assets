require 'gitlab'

def get_public_assets()
    groups = Gitlab.groups(per_page: 1000)
    users = Gitlab.users(per_page:1000)
    public_groups = []
    public_repos = []
    public_user_repos = []

    #get public group projects
    groups.each do |current_group|
        puts "%s" % [current_group.name]
        if current_group.visibility == "public"
            public_groups.push(current_group)
        end
        public_repos.concat(get_public_group_repos(current_group.id))
    end

    #get public user projects
    users.each do |current_user|
        puts "%s" % [current_user.name]
        public_user_repos.concat(get_public_user_repos(current_user.id))
    end

    return [public_groups, public_repos, public_user_repos]
end

def get_public_group_repos(group_id)
    group_repos = Gitlab.group_projects(group_id)
    public_repos = []
    group_repos.each do |group_project|
        puts "  %s: %s" % [group_project.name, group_project.visibility]
        if group_project.visibility == "public"
            public_repos.push(group_project)
        end
    end
    return public_repos
end

def get_public_user_repos(user_id)
    user_projects = Gitlab.user_projects(user_id)
    public_repos = []
    user_projects.each do |user_project|
        puts "  %s: %s" % [user_project.name, user_project.visibility]
        if user_project.visibility == "public"
            public_repos.push(user_project)
        end
    end
    return public_repos 
end

public_assets = get_public_assets()

asset_types = ["groups", "repos", "user repos"]

public_assets.each_with_index do |public_assets, index|
    puts "There are %d public %s: " % [public_assets.count, asset_types[index]]
    public_assets.each do |public_asset|
        puts "- %s" % [public_asset.name]
    end
end
