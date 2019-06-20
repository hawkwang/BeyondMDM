package com.etiir.mdm.util;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.jumpmind.symmetric.model.NodeGroupLinkAction;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * @author lmx
 * @packageName com.etiir.mdm.util
 * @description
 * @data 2019/6/11 15:34
 */
public class NodeGroupLinkActionHandler extends
        BaseTypeHandler<NodeGroupLinkAction> {
    @Override
    public void setNonNullParameter(PreparedStatement preparedStatement, int i, NodeGroupLinkAction nodeGroupLinkAction, JdbcType jdbcType) throws SQLException {
        preparedStatement.setString(i,nodeGroupLinkAction.name());
    }

    private NodeGroupLinkAction convert(String s){
        for(NodeGroupLinkAction action: NodeGroupLinkAction.values()){
            if(s.equals(action.name())){
                return action;
            }
        }
        return null;
    }

    @Override
    public NodeGroupLinkAction getNullableResult(ResultSet resultSet, String s) throws SQLException {
        return convert(s);
    }

    @Override
    public NodeGroupLinkAction getNullableResult(ResultSet resultSet, int i) throws SQLException {
        return convert(resultSet.getString(i));
    }

    @Override
    public NodeGroupLinkAction getNullableResult(CallableStatement callableStatement, int i) throws SQLException {
        return convert(callableStatement.getString(i));
    }
}
