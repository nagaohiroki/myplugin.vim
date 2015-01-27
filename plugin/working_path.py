import os
import vim
# ------------------------------------------------------------------------
##
# @brief 
#
# @return 
# ------------------------------------------------------------------------
def get_svn_working_path():
    svninfo = os.popen( 'svn info') .read()
    svninfosplit = svninfo.split( '\n' )
    count = len( svninfosplit )
    if count >= 2:
        working_path = svninfosplit[1]
        result = working_path[24:]
        return result
    return ''

 
# ------------------------------------------------------------------------
##
# @brief 
#
# @return 
# ------------------------------------------------------------------------
def get_git_working_path():
    result = os.popen('git rev-parse --show-toplevel').read()
    return result.replace('\n','')

# ------------------------------------------------------------------------
##
# @brief 
#
# @param name
#
# @return 
# ------------------------------------------------------------------------
def py2vim(name):
  cmd = "let %s = %s" % (name , repr(eval(name)))
  vim.command(cmd)

if __name__ == '__main__':
    py_working_path = ''
    svn_path = get_svn_working_path()
    if svn_path != '':
        py_working_path = svn_path
        
    git_path = get_git_working_path()
    if git_path != '':
       py_working_path = git_path

    py2vim( 'py_working_path' )
    
