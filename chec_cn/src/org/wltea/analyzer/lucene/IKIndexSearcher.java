/**
 * 
 */
package org.wltea.analyzer.lucene;

import java.io.IOException;

import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.search.Collector;
import org.apache.lucene.search.Filter;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.store.Directory;

/**
 * <p>
 * 重写查询
 * </p>
 * 
 * @author ZY
 * @email zy_8516@163.com
 * @date 2011-3-13 上午09:42:16
 */
public class IKIndexSearcher extends IndexSearcher {

	public IKIndexSearcher(Directory path) throws CorruptIndexException,
			IOException {
		super(path);
	}

	public void search(Query query, Filter[] filters, Collector results)
			throws IOException {
		if (filters != null && filters.length > 0) {
			for (Filter filter : filters) {
				search(createWeight(query), filter, results);
			}
		}
	}
}
