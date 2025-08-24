import UserLink from "discourse/components/user-link";
import avatar from "discourse/helpers/avatar";
import icon from "discourse/helpers/d-icon";
import formatDate from "discourse/helpers/format-date";
import { apiInitializer } from "discourse/lib/api";
import { i18n } from "discourse-i18n";

export default apiInitializer((api) => {
  if (!api.container.lookup("service:site").mobileView) {
    return;
  }

  api.renderInOutlet(
    "topic-list-before-reply-count",
    <template>{{icon "far-comment-dots"}}</template>
  );

  api.renderInOutlet(
    "topic-list-item-mobile-avatar",
    <template>
      <UserLink
        @ariaLabel={{i18n
          "latest_poster_link"
          username=@topic.creator.username
        }}
        @username={{@topic.creator.username}}
      >
        {{avatar @topic.creator imageSize="large"}}</UserLink>
    </template>
  );

  api.renderInOutlet(
    "topic-list-after-category",
    <template>
      <span class="latest-poster-and-time__container">
        <span class="latest-poster-and-time">
          {{#if @topic.replyCount}}
            <a
              href={{@topic.lastPostUrl}}
              aria-label={{i18n
                "latest_poster_link"
                username=@topic.lastPosterUser.username
              }}
              data-user-card={{@topic.lastPosterUser.username}}
            >{{avatar @topic.lastPosterUser imageSize="small"}}</a>
          {{else}}
            {{icon "far-clock"}}
          {{/if}}

          <span title={{@topic.bumpedAtTitle}} class="age activity">
            <a href={{@topic.lastPostUrl}}>{{formatDate
                @topic.bumpedAt
                format="tiny"
                noTitle="true"
              }}</a>
          </span>
        </span>
      </span>
    </template>
  );
});
