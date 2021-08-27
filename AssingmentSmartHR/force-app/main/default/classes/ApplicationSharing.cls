public class ApplicationSharing {
    public static boolean manualShareRead(ID recordId, ID userOrGroupId){
        Application__Share applicationShare = new Application__Share();
        applicationShare.ParentId = recordId;
        applicationShare.UserOrGroupId = UserOrGroupId;
        applicationShare.AccessLevel = 'Read';
        applicationShare.RowCause = Schema.Application__Share.RowCause.Manual;
        Database.SaveResult saveResult = Database.insert(applicationShare, false);
        if(saveResult.isSuccess()){
        	return true;
        }else{
            Database.Error error = saveResult.getErrors()[0];
            if(error.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  &&  
                  error.getMessage().contains('AccessLevel')){
                return true;
            }
            else{
                return false;
            }
        }        
    }
    public static boolean hidePermission(ID recordId, ID userOrGroupId){
        Application__Share applicationShare = new Application__Share();
        applicationShare.ParentId = recordId;
        applicationShare.UserOrGroupId = UserOrGroupId;
        applicationShare.AccessLevel = '';
        applicationShare.RowCause = Schema.Application__Share.RowCause.Manual;
        Database.SaveResult saveResult = Database.insert(applicationShare, false);
        if(saveResult.isSuccess()){
        	return true;
        }else{
            Database.Error error = saveResult.getErrors()[0];
            if(error.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  &&  
                  error.getMessage().contains('AccessLevel')){
                return true;
            }
            else{
                return false;
            }
        }        
    }
}