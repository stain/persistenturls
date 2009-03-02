package org.purl.accessor.util;

import org.ten60.netkernel.layer1.nkf.INKFConvenienceHelper;
import org.ten60.netkernel.layer1.nkf.NKFException;

public class GroupResolver extends URIResolver {

    @Override
    public String getURI(INKFConvenienceHelper context) {
        String retValue = null;

        try {
            retValue = getURI(NKHelper.getLastSegment(context));
        } catch(NKFException nfe) {
            nfe.printStackTrace();
        }

        return retValue;
    }

    @Override
    public String getURI(String id) {
        return "ffcpl:/group/" + getDisplayName(id);
    }

    @Override
    public String getDisplayName(String id) {
        String retValue = null;
        
        if(!id.startsWith("ffcpl:/group/") && !id.startsWith("ffcpl:/admin/group")) {
            retValue = id;
        } else {
            if(id.startsWith("ffcpl:/admin/group")){
                retValue = id.substring(19);
            } else {
                retValue = id.substring(13);
            }
        }
        
        return retValue;
    }
}
