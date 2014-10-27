module VisibilityLevelHelper
  def visibility_level_color(level)
    case level
    when Gitlab::VisibilityLevel::PRIVATE
      'vs-private'
    when Gitlab::VisibilityLevel::INTERNAL
      'vs-internal'
    when Gitlab::VisibilityLevel::PUBLIC
      'vs-public'
    end
  end

  def visibility_level_description(level)
    capture_haml do
      haml_tag :span do
        case level
        when Gitlab::VisibilityLevel::PRIVATE
          haml_concat "私有项目只有授权用户才能访问"
        when Gitlab::VisibilityLevel::INTERNAL
          haml_concat "内部项目只要登录就可以访问"
        when Gitlab::VisibilityLevel::PUBLIC
          haml_concat "公共项目所有人都可以访问"
        end
      end
    end
  end

  def snippet_visibility_level_description(level)
    capture_haml do
      haml_tag :span do
        case level
        when Gitlab::VisibilityLevel::PRIVATE
          haml_concat "只有自己能看"
        when Gitlab::VisibilityLevel::INTERNAL
          haml_concat "登录后可看"
        when Gitlab::VisibilityLevel::PUBLIC
          haml_concat "所有人可看"
        end
      end
    end
  end

  def visibility_level_icon(level)
    case level
    when Gitlab::VisibilityLevel::PRIVATE
      private_icon
    when Gitlab::VisibilityLevel::INTERNAL
      internal_icon
    when Gitlab::VisibilityLevel::PUBLIC
      public_icon
    end
  end

  def visibility_level_label(level)
    Project.visibility_levels.key(level)
  end

  def restricted_visibility_levels
    current_user.is_admin? ? [] : gitlab_config.restricted_visibility_levels
  end
end
