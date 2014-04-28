package com.glamey.chec_cn.dao;

import com.glamey.chec_cn.constants.CategoryConstants;
import com.glamey.chec_cn.model.domain.Post;
import com.glamey.chec_cn.util.outside.SqlServerConnection;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by zy
 */

@Repository
public class ChecDao {

    public List<Post> getChecNews(String startDate,String endDate,String nodeId) {
        if (StringUtils.isBlank(nodeId))
            return null;
        List<Post> list = new ArrayList<Post>();
        Post post = null;
        try {
            Connection conn = SqlServerConnection.getChecConnection();
            /*String sql = "SELECT title,brief,content,addtime from catalog_001_item where nodeid = '10' and addtime >= ? and addtime <= ? order by addtime desc ;";*/
            String sql = "SELECT title,brief,content,addtime from catalog_001_item where nodeid = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            /*pstmt.setString(1, yestoday + " 00:00:00");
            pstmt.setString(2, yestoday + " 23:59:59");*/
            pstmt.setString(1,nodeId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                post = new Post();
                post.setTitle(rs.getString("title"));
                post.setSummary(rs.getString("brief"));
                post.setContent(rs.getString("content"));
                post.setPublishTime(rs.getDate("addtime"));
                post.setUpdateTime(post.getPublishTime());

                //新闻
                if (StringUtils.equals(nodeId,"10")) {
                    post.setCategoryId(CategoryConstants.CATEGORY_ID_GONGSIXINWEN);
                    post.setCategoryType(CategoryConstants.CATEGORY_NEWS);
                }
                //审计监察--监审动态
                if (StringUtils.equals(nodeId,"63")) {
                    post.setCategoryId(CategoryConstants.CATEGORY_ID_JCSJ_JIANSHENDONGTAI);
                    post.setCategoryType(CategoryConstants.CATEGORY_JCSJ);
                }
                //审计监察--案例分析
                if (StringUtils.equals(nodeId,"64")) {
                    post.setCategoryId(CategoryConstants.CATEGORY_ID_JCSJ_ANLIFENXI);
                    post.setCategoryType(CategoryConstants.CATEGORY_JCSJ);
                }
                //审计监察--法规制度
                if (StringUtils.equals(nodeId,"65")) {
                    post.setCategoryId(CategoryConstants.CATEGORY_ID_JCSJ_FAGUIZHIDU);
                    post.setCategoryType(CategoryConstants.CATEGORY_JCSJ);
                }

                //公司介绍-公司简介
                if (StringUtils.equals(nodeId,"65")) {
                    post.setCategoryId(CategoryConstants.CATEGORY_ID_JCSJ_FAGUIZHIDU);
                    post.setCategoryType(CategoryConstants.CATEGORY_JCSJ);
                }
                //公司介绍-资质荣誉
                if (StringUtils.equals(nodeId,"8")) {
                    post.setCategoryId(CategoryConstants.CATEGORY_ID_INTRODUCE_ZZRY_ZIZHI);
                    post.setCategoryType(CategoryConstants.CATEGORY_INTRODUCE);
                }
                list.add(post);
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
