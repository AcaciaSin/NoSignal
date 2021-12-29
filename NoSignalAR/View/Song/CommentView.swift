//
//  CommentView.swift
//  NoSignal
//
//  Created by student9 on 2021/12/24.
//

import SwiftUI
import NeumorphismSwiftUI

extension CommentSongResponse.Comment: Identifiable {
    public var id: Int { commentId }
}

extension CommentSongResponse.Comment.BeReplied: Identifiable {
    public var id: Int { beRepliedCommentId }
}

struct CommentView: View {
    let id: Int
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    BackWardButton()
                    Spacer()
                    MyNavigationBarTitleView("歌曲评论")
                    Spacer()
                    Button(action: {}) {
                        NeteaseSongCoverView(systemName: "ellipsis" , size:  .medium)
                        Image(systemName: "ellipsis")
                            .font(.title2)
                    }
                }
                .padding(.horizontal)
                CommentListView(id: id)
            }
        }
    }
}


struct CommentListView: View {
    @EnvironmentObject private var store: Store
    private var comment: AppState.Comment { store.appState.comment }
    @State private var editComment: String = ""
    @State private var showCancel: Bool = false
    let id: Int
    
    var body: some View {
        VStack {
            HStack {
                TextField("编辑评论", text: $editComment,
                          onEditingChanged: { isEditing in
                            if showCancel != isEditing {
                                showCancel = isEditing
                            }
                          })
                    .textFieldStyle(SearchDefaultTextFieldStyle(label: Image(systemName: "pencil")))
                if showCancel {
                    Button(action: {
                        editComment = ""
                        hideKeyboard()
                    }, label: {
                        Text("取消")
                            .foregroundColor(.secondary)
                    })
                }
                Button(action: {
                    hideKeyboard()
                    Store.shared.dispatch(.commentRequest(id: id, content: editComment, type: .song, action: .add))
                    editComment = ""
                }) {
                    Image(systemName: "plus.message")
                }
            }
            .padding()
            .onAppear {
                if Store.shared.appState.comment.id != id {
                    Store.shared.dispatch(.commentMusicRequest(rid: id))
                }
            }
            if comment.commentMusicRequesting {
                Text("正在加载...")
                Spacer()
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        HStack {
                            Text("热门评论(\(String(comment.hotComments.count)))")
                            Spacer()
                        }
                        ForEach(comment.hotComments) { item in
                            CommentRowView(viewModel: CommentViewModel(item), id: id, type: .song)
                            Divider()
                        }
                        HStack {
                            Text("最新评论(\(String(comment.total)))")
//                                .foregroundColor(.mainText)
                            Spacer()
                        }
                        ForEach(comment.comments) { item in
                            CommentRowView(viewModel: CommentViewModel(item), id: id, type: .song)
                            Divider()
                        }
                    }
                    .padding(.horizontal)
                    if comment.comments.count < comment.total {
                        Button(action: {
                            Store.shared.dispatch(.commentMusicLoadMoreRequest)
                        }, label: {
                            Text("Load more")
                        })
                    }
                    Spacer()
                        .frame(height: 20)
                }
            }
        }
    }
}

struct CommentRowView: View {
    @EnvironmentObject var store: Store
    private var user: User? { store.appState.settings.loginUser }

    @StateObject var viewModel: CommentViewModel
    let id: Int
    let type: CommentType
    
    @State var showBeReplied = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            RectangleCoverView(viewModel.avatarUrl, style: CoverStyle(size: .little, shape: .rectangle))
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text(viewModel.nickname)
                        .font(.headline)
                    Spacer()
                    Text(String(viewModel.likedCount))
                    Button(action: {
                        Store.shared.dispatch(.commentLikeRequest(id: id, cid: viewModel.commentId, like: viewModel.liked ? false : true, type: type))
                        viewModel.liked.toggle()
                    }, label: {
                        Image(systemName: viewModel.liked ? "hand.thumbsup.fill" : "hand.thumbsup")
                    })
                }
                Text(viewModel.content)
                    .font(.subheadline)
                HStack {
                    if viewModel.beReplied.count > 0 {
                        Button(action: {
                            showBeReplied.toggle()
                        }, label: {
                            HStack(spacing: 0.0) {
                                Text("\(viewModel.beReplied.count)条回复")
                                    .font(.subheadline)
                                Image(systemName: showBeReplied ? "chevron.down" : "chevron.up")
                                    .font(.subheadline)
                            }
                            .padding(.top, 1)
                        })
                    }
                    Spacer()
                    if viewModel.userId == user?.userId ?? 0 {
                        Button(action: {
                            Store.shared.dispatch(.commentRequest(id: id, commentId: viewModel.commentId, type: type, action: .delete))
                        }, label: {
                            Text("删除")
                        })
                    }
                }
                if showBeReplied {
                    ForEach(viewModel.beReplied) { item in
                        CommentRowView(viewModel: item, id: id, type: type)
                    }
                }
            }
        }
    }
}


protocol SearchTextFieldStyle: TextFieldStyle, NEUStyle {
    
}

public struct SearchDefaultTextFieldStyle<Label>: SearchTextFieldStyle where Label: View {
    let label: Label
    
    public init(label: Label) {
        self.label = label
    }
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        HStack() {
            label
            configuration
        }
//        .padding(.horizontal)
//        .padding(.vertical, 10)
    }
}
