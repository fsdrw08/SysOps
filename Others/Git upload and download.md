
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
git remote add origin &lt;address&gt;

# add other source 
git remote add another &lt;address&gt;

# 6. Upload: 
git push origin master

# 7. Upload to another repo: 
git push --mirror &lt;address&gt;



# ·Git download

# 1. Cancel local change: 
git stash

git stash list

git stash drop stash@{*}

# 2. Download: 
git pull origin

# 3. Partical download
git clone --filter=blob:none --no-checkout &lt;repo address&gt;

cd &lt;repo dir&gt;

git sparse-checkout init --cone

git sparse-checkout set &lt;sub folder&gt; // &lt; - no forward slash in the begin and the end of the sub folder path

git checkout

# .Git roll back
git log &lt;file path&gt;

git revert -n &lt;commit id&gt;

git commit -m ""
