/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package peasy.org.apache.commons.math.geometry;

import peasy.org.apache.commons.math.MathException;

/**
 * This class represents exceptions thrown while building rotations from
 * matrices.
 *
 * @version $Revision: 627994 $ $Date: 2008-02-15 03:16:05 -0700 (Fri, 15 Feb
 *          2008) $
 * @since 1.2
 */

public class NotARotationMatrixException extends MathException {

	/**
	 * Simple constructor. Build an exception by translating and formating a
	 * message
	 *
	 * @param specifier
	 *            format specifier (to be translated)
	 * @param parts
	 *            to insert in the format (no translation)
	 */
	public NotARotationMatrixException(final String specifier, final Object[] parts) {
		super(specifier, parts);
	}

	/** Serializable version identifier */
	private static final long serialVersionUID = 5647178478658937642L;

}
