/*
 *    Copyright (c) 2018-2025, lengleng All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution.
 * Neither the name of the pig4cloud.com developer nor the names of its
 * contributors may be used to endorse or promote products derived from
 * this software without specific prior written permission.
 * Author: lengleng (wangiegie@gmail.com)
 */

package com.pig4cloud.pigx.common.security.component;

import com.pig4cloud.pigx.common.security.service.PigxUser;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.oauth2.provider.token.UserAuthenticationConverter;
import org.springframework.util.StringUtils;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * @author lengleng
 * @date 2019-03-07
 * <p>
 * 根据checktoken 的结果转化用户信息
 */
public class PigxUserAuthenticationConverter implements UserAuthenticationConverter {
	private static final String USER_ID = "user_id";
	private static final String DEPT_ID = "dept_id";
	private static final String TENANT_ID = "tenant_id";
	private static final String N_A = "N/A";

	/**
	 * Extract information about the user to be used in an access token (i.e. for resource servers).
	 *
	 * @param authentication an authentication representing a user
	 * @return a map of key values representing the unique information about the user
	 */
	@Override
	public Map<String, ?> convertUserAuthentication(Authentication authentication) {
		Map<String, Object> response = new LinkedHashMap<>();
		response.put(USERNAME, authentication.getName());
		if (authentication.getAuthorities() != null && !authentication.getAuthorities().isEmpty()) {
			response.put(AUTHORITIES, AuthorityUtils.authorityListToSet(authentication.getAuthorities()));
		}
		return response;
	}

	/**
	 * Inverse of {@link #convertUserAuthentication(Authentication)}. Extracts an Authentication from a map.
	 *
	 * @param map a map of user information
	 * @return an Authentication representing the user or null if there is none
	 */
	@Override
	public Authentication extractAuthentication(Map<String, ?> map) {
		if (map.containsKey(USERNAME)) {
			Collection<? extends GrantedAuthority> authorities = getAuthorities(map);

			String username = (String) map.get(USERNAME);
			Integer id = (Integer) map.get(USER_ID);
			Integer deptId = (Integer) map.get(DEPT_ID);
			Integer tenantId = (Integer) map.get(TENANT_ID);
			PigxUser user = new PigxUser(id, deptId, tenantId, username, N_A, true
					, true, true, true, authorities);
			return new UsernamePasswordAuthenticationToken(user, N_A, authorities);
		}
		return null;
	}

	private Collection<? extends GrantedAuthority> getAuthorities(Map<String, ?> map) {
		Object authorities = map.get(AUTHORITIES);
		if (authorities instanceof String) {
			return AuthorityUtils.commaSeparatedStringToAuthorityList((String) authorities);
		}
		if (authorities instanceof Collection) {
			return AuthorityUtils.commaSeparatedStringToAuthorityList(StringUtils
					.collectionToCommaDelimitedString((Collection<?>) authorities));
		}
		throw new IllegalArgumentException("Authorities must be either a String or a Collection");
	}
}
