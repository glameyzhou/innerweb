package org.apache.lucene.analysis;

/**
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import java.io.File;
import java.io.IOException;
import java.io.Reader;
import java.util.Arrays;
import java.util.Set;
import java.util.List;

import org.apache.lucene.util.Version;

/** Filters {@link LetterTokenizer} with {@link LowerCaseFilter} and {@link org.apache.lucene.analysis.StopFilter}.
 *
 * <a name="version"/>
 * <p>You must specify the required {@link org.apache.lucene.util.Version}
 * compatibility when creating StopAnalyzer:
 * <ul>
 *   <li> As of 2.9, position increments are preserved
 * </ul>
*/

public final class StopAnalyzer extends Analyzer {
  private final Set<?> stopWords;
  private final boolean enablePositionIncrements;
  
  /** An unmodifiable set containing some common English words that are not usually useful
  for searching.*/
  public static final Set<?> ENGLISH_STOP_WORDS_SET;
  
  static {
    final List<String> stopWords = Arrays.asList(
      "a", "an", "and", "are", "as", "at", "be", "but", "by",
      "for", "if", "in", "into", "is", "it",
      "no", "not", "of", "on", "or", "such",
      "that", "the", "their", "then", "there", "these",
      "they", "this", "to", "was", "will", "with"
    );
    final CharArraySet stopSet = new CharArraySet(stopWords.size(), false);
    stopSet.addAll(stopWords);  
    ENGLISH_STOP_WORDS_SET = CharArraySet.unmodifiableSet(stopSet); 
  }
  
  /** Builds an analyzer which removes words in
   *  {@link #ENGLISH_STOP_WORDS_SET}.
   * @param matchVersion See <a href="#version">above</a>
   */
  public StopAnalyzer(Version matchVersion) {
    stopWords = ENGLISH_STOP_WORDS_SET;
    enablePositionIncrements = StopFilter.getEnablePositionIncrementsVersionDefault(matchVersion);
  }

  /** Builds an analyzer with the stop words from the given set.
   * @param matchVersion See <a href="#version">above</a>
   * @param stopWords Set of stop words */
  public StopAnalyzer(Version matchVersion, Set<?> stopWords) {
    this.stopWords = stopWords;
    enablePositionIncrements = StopFilter.getEnablePositionIncrementsVersionDefault(matchVersion);
  }

  /** Builds an analyzer with the stop words from the given file.
   * @see WordlistLoader#getWordSet(java.io.File)
   * @param matchVersion See <a href="#version">above</a>
   * @param stopwordsFile File to load stop words from */
  public StopAnalyzer(Version matchVersion, File stopwordsFile) throws IOException {
    stopWords = WordlistLoader.getWordSet(stopwordsFile);
    this.enablePositionIncrements = StopFilter.getEnablePositionIncrementsVersionDefault(matchVersion);
  }

  /** Builds an analyzer with the stop words from the given reader.
   * @see WordlistLoader#getWordSet(java.io.Reader)
   * @param matchVersion See <a href="#version">above</a>
   * @param stopwords Reader to load stop words from */
  public StopAnalyzer(Version matchVersion, Reader stopwords) throws IOException {
    stopWords = WordlistLoader.getWordSet(stopwords);
    this.enablePositionIncrements = StopFilter.getEnablePositionIncrementsVersionDefault(matchVersion);
  }

  /** Filters LowerCaseTokenizer with StopFilter. */
  @Override
  public TokenStream tokenStream(String fieldName, Reader reader) {
    return new StopFilter(enablePositionIncrements, new LowerCaseTokenizer(reader), stopWords);
  }

  /** Filters LowerCaseTokenizer with StopFilter. */
  private class SavedStreams {
    Tokenizer source;
    TokenStream result;
  };
  @Override
  public TokenStream reusableTokenStream(String fieldName, Reader reader) throws IOException {
    SavedStreams streams = (SavedStreams) getPreviousTokenStream();
    if (streams == null) {
      streams = new SavedStreams();
      streams.source = new LowerCaseTokenizer(reader);
      streams.result = new StopFilter(enablePositionIncrements, streams.source, stopWords);
      setPreviousTokenStream(streams);
    } else
      streams.source.reset(reader);
    return streams.result;
  }
}
