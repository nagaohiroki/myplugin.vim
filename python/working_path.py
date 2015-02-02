import os
# ------------------------------------------------------------------------
##
# @brief 
# ------------------------------------------------------------------------
class WorkinPath:
    # ------------------------------------------------------------------------
    ##
    # @brief 
    #
    # @return 
    # ------------------------------------------------------------------------
    def get_svn_working_path(self):
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
    def get_git_working_path(self):
        result = os.popen('git rev-parse --show-toplevel').read()
        return result.replace('\n','')

    # ------------------------------------------------------------------------
    ##
    # @brief 
    #
    # @return 
    # ------------------------------------------------------------------------
    def get_working_path(self):
        py_working_path = ''
        svn_path = self.get_svn_working_path()
        if svn_path != '':
            py_working_path = svn_path
            
        git_path = self.get_git_working_path()
        if git_path != '':
           py_working_path = git_path
        return py_working_path

