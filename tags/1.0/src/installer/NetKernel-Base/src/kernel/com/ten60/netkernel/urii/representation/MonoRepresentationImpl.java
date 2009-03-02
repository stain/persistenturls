/******************************************************************************
 * (c) Copyright 2002,2003, 1060 Research Ltd
 *
 * This Software is licensed to You, the licensee, for use under the terms of
 * the 1060 Public License v1.0. Please read and agree to the 1060 Public
 * License v1.0 [www.1060research.com/license] before using or redistributing
 * this software.
 *
 * In summary the 1060 Public license has the following conditions.
 * A. You may use the Software free of charge provided you agree to the terms
 * laid out in the 1060 Public License v1.0
 * B. You are only permitted to use the Software with components or applications
 * that provide you with OSI Certified Open Source Code [www.opensource.org], or
 * for which licensing has been approved by 1060 Research Limited.
 * You may write your own software for execution by this Software provided any
 * distribution of your software with this Software complies with terms set out
 * in section 2 of the 1060 Public License v1.0
 * C. You may redistribute the Software provided you comply with the terms of
 * the 1060 Public License v1.0 and that no warranty is implied or given.
 * D. If you find you are unable to comply with this license you may seek to
 * obtain an alternative license from 1060 Research Limited by contacting
 * license@1060research.com or by visiting www.1060research.com
 *
 * NO WARRANTY:  THIS SOFTWARE IS NOT COVERED BY ANY WARRANTY. SEE 1060 PUBLIC
 * LICENSE V1.0 FOR DETAILS
 *
 * THIS COPYRIGHT NOTICE IS *NOT* THE 1060 PUBLIC LICENSE v1.0. PLEASE READ
 * THE DISTRIBUTED 1060_Public_License.txt OR www.1060research.com/license
 *
 * File:          $RCSfile: MonoRepresentationImpl.java,v $
 * Version:       $Name:  $ $Revision: 1.1 $
 * Last Modified: $Date: 2004/06/18 10:15:23 $
 *****************************************************************************/
package com.ten60.netkernel.urii.representation;

import com.ten60.netkernel.urii.IURRepresentation;
import com.ten60.netkernel.urii.IURAspect;
import com.ten60.netkernel.urii.*;
import java.util.*;
/**
 * Generic implementation of an IURRepresentation that has only one interface implementor
 * @author  tab
 */
public final class MonoRepresentationImpl implements IURRepresentation
{
	/** the interface implementor */
	private IURAspect mAspect;
	/** meta */
	private IURMeta mMeta;
	
	/** Construct a new RepresentationImpl
	 * @param aMeta the meta for our new representation
	 * @param aInterface the interface implementor for our new representation
	 */
	public MonoRepresentationImpl(IURMeta aMeta, IURAspect aAspect)
	{	mMeta=aMeta;
		mAspect=aAspect;
	}
	
	/** return the meta */
	public IURMeta getMeta()
	{	return mMeta;
	}
	
	/** Returns true if the aspect implements the given interface */
	public boolean hasAspect(Class aAspectClass)
	{	return aAspectClass.isAssignableFrom(mAspect.getClass());
	}
	/** Return the aspect */
	public IURAspect getAspect(Class aAspectClass)
	{	return mAspect;
	}
	/** Return just the single aspect */
	public Collection getAspects()
	{	return Collections.singletonList(mAspect);
	}
}