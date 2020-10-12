
# Git upload
# 0. Config user:
git config --global user.name "My Name"
git config --global user.email "myemail@example.com"

# 1. Initialize: 
git init

# 2. Add files: 
git add .

# 3. Check status: 
git status -s

# 4. Commit: 
git commit -m "<comment>"

# 5. Add origin source: 
git remote add origin <address> 
# add other source 
git remote add another <address>

# 6. Upload: 
git push origin master

# 7. Upload to another repo: 
git push --mirror <address>


# ·Git download

# 1. Cancel local change: 
git stash
git stash list
git stash drop stash@{*}

# 2. Download: 
git pull origin

